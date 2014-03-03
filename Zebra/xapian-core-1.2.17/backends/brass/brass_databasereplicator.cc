/** @file brass_databasereplicator.cc
 * @brief Support for brass database replication
 */
/* Copyright 2008 Lemur Consulting Ltd
 * Copyright 2009,2010 Olly Betts
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
 * USA
 */

#include <config.h>

#include "brass_databasereplicator.h"

#include "xapian/error.h"

#include "../flint_lock.h"
#include "brass_record.h"
#include "brass_replicate_internal.h"
#include "brass_types.h"
#include "brass_version.h"
#include "debuglog.h"
#include "io_utils.h"
#include "pack.h"
#include "remoteconnection.h"
#include "replicationprotocol.h"
#include "safeerrno.h"
#include "str.h"
#include "stringutils.h"
#include "utils.h"

#ifdef __WIN32__
# include "msvc_posix_wrapper.h"
#endif

#include <cstdio> // For rename().

using namespace std;
using namespace Xapian;

BrassDatabaseReplicator::BrassDatabaseReplicator(const string & db_dir_)
	: db_dir(db_dir_)
{
}

bool
BrassDatabaseReplicator::check_revision_at_least(const string & rev,
						 const string & target) const
{
    LOGCALL(DB, bool, "BrassDatabaseReplicator::check_revision_at_least", rev | target);

    brass_revision_number_t rev_val;
    brass_revision_number_t target_val;

    const char * ptr = rev.data();
    const char * end = ptr + rev.size();
    if (!unpack_uint(&ptr, end, &rev_val)) {
	throw NetworkError("Invalid revision string supplied to check_revision_at_least");
    }

    ptr = target.data();
    end = ptr + target.size();
    if (!unpack_uint(&ptr, end, &target_val)) {
	throw NetworkError("Invalid revision string supplied to check_revision_at_least");
    }

    RETURN(rev_val >= target_val);
}

void
BrassDatabaseReplicator::process_changeset_chunk_base(const string & tablename,
						      string & buf,
						      RemoteConnection & conn,
						      double end_time) const
{
    const char *ptr = buf.data();
    const char *end = ptr + buf.size();

    // Get the letter
    char letter = ptr[0];
    if (letter != 'A' && letter != 'B')
	throw NetworkError("Invalid base file letter in changeset");
    ++ptr;


    // Get the base size
    if (ptr == end)
	throw NetworkError("Unexpected end of changeset (5)");
    string::size_type base_size;
    if (!unpack_uint(&ptr, end, &base_size))
	throw NetworkError("Invalid base file size in changeset");

    // Get the new base file into buf.
    buf.erase(0, ptr - buf.data());
    conn.get_message_chunk(buf, base_size, end_time);

    if (buf.size() < base_size)
	throw NetworkError("Unexpected end of changeset (6)");

    // Write base_size bytes from start of buf to base file for tablename
    string tmp_path = db_dir + "/" + tablename + "tmp";
    string base_path = db_dir + "/" + tablename + ".base" + letter;
#ifdef __WIN32__
    int fd = msvc_posix_open(tmp_path.c_str(), O_WRONLY | O_CREAT | O_TRUNC | O_BINARY);
#else
    int fd = ::open(tmp_path.c_str(), O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0666);
#endif
    if (fd == -1) {
	string msg = "Failed to open ";
	msg += tmp_path;
	throw DatabaseError(msg, errno);
    }
    {
	fdcloser closer(fd);

	io_write(fd, buf.data(), base_size);
	io_sync(fd);
    }
#if defined __WIN32__
    if (msvc_posix_rename(tmp_path.c_str(), base_path.c_str()) < 0) {
#else
    if (rename(tmp_path.c_str(), base_path.c_str()) < 0) {
#endif
	// With NFS, rename() failing may just mean that the server crashed
	// after successfully renaming, but before reporting this, and then
	// the retried operation fails.  So we need to check if the source
	// file still exists, which we do by calling unlink(), since we want
	// to remove the temporary file anyway.
	int saved_errno = errno;
	if (unlink(tmp_path) == 0 || errno != ENOENT) {
	    string msg("Couldn't update base file ");
	    msg += tablename;
	    msg += ".base";
	    msg += letter;
	    throw DatabaseError(msg, saved_errno);
	}
    }

    buf.erase(0, base_size);
}

void
BrassDatabaseReplicator::process_changeset_chunk_blocks(const string & tablename,
							string & buf,
							RemoteConnection & conn,
							double end_time) const
{
    const char *ptr = buf.data();
    const char *end = ptr + buf.size();

    unsigned int changeset_blocksize;
    if (!unpack_uint(&ptr, end, &changeset_blocksize))
	throw NetworkError("Invalid blocksize in changeset");
    buf.erase(0, ptr - buf.data());

    string db_path = db_dir + "/" + tablename + ".DB";
#ifdef __WIN32__
    int fd = msvc_posix_open(db_path.c_str(), O_WRONLY | O_CREAT | O_BINARY);
#else
    int fd = ::open(db_path.c_str(), O_WRONLY | O_CREAT | O_BINARY, 0666);
#endif
    if (fd == -1) {
	string msg = "Failed to open ";
	msg += db_path;
	throw DatabaseError(msg, errno);
    }
    {
	fdcloser closer(fd);

	while (true) {
	    conn.get_message_chunk(buf, REASONABLE_CHANGESET_SIZE, end_time);
	    ptr = buf.data();
	    end = ptr + buf.size();

	    uint4 block_number;
	    if (!unpack_uint(&ptr, end, &block_number))
		throw NetworkError("Invalid block number in changeset");
	    buf.erase(0, ptr - buf.data());
	    if (block_number == 0)
		break;
	    --block_number;

	    conn.get_message_chunk(buf, changeset_blocksize, end_time);
	    if (buf.size() < changeset_blocksize)
		throw NetworkError("Incomplete block in changeset");

	    // Write the block.
	    // FIXME - should use pwrite if that's available.
	    if (lseek(fd, off_t(changeset_blocksize) * block_number, SEEK_SET) == -1) {
		string msg = "Failed to seek to block ";
		msg += str(block_number);
		throw DatabaseError(msg, errno);
	    }
	    io_write(fd, buf.data(), changeset_blocksize);

	    buf.erase(0, changeset_blocksize);
	}
	io_sync(fd);
    }
}

string
BrassDatabaseReplicator::apply_changeset_from_conn(RemoteConnection & conn,
						   double end_time,
						   bool valid) const
{
    LOGCALL(DB, string, "BrassDatabaseReplicator::apply_changeset_from_conn", conn | end_time | valid);

    // Lock the database to perform modifications.
    FlintLock lock(db_dir);
    string explanation;
    FlintLock::reason why = lock.lock(true, explanation);
    if (why != FlintLock::SUCCESS) {
	lock.throw_databaselockerror(why, db_dir, explanation);
    }

    char type = conn.get_message_chunked(end_time);
    (void) type; // Don't give warning about unused variable.
    AssertEq(type, REPL_REPLY_CHANGESET);

    string buf;
    // Read enough to be certain that we've got the header part of the
    // changeset.

    conn.get_message_chunk(buf, REASONABLE_CHANGESET_SIZE, end_time);
    // Check the magic string.
    if (!startswith(buf, CHANGES_MAGIC_STRING)) {
	throw NetworkError("Invalid ChangeSet magic string");
    }
    buf.erase(0, 12);
    const char *ptr = buf.data();
    const char *end = ptr + buf.size();

    unsigned int changes_version;
    if (!unpack_uint(&ptr, end, &changes_version))
	throw NetworkError("Couldn't read a valid version number from changeset");
    if (changes_version != CHANGES_VERSION)
	throw NetworkError("Unsupported changeset version");

    brass_revision_number_t startrev;
    brass_revision_number_t endrev;

    if (!unpack_uint(&ptr, end, &startrev))
	throw NetworkError("Couldn't read a valid start revision from changeset");
    if (!unpack_uint(&ptr, end, &endrev))
	throw NetworkError("Couldn't read a valid end revision from changeset");

    if (endrev <= startrev)
	throw NetworkError("End revision in changeset is not later than start revision");

    if (ptr == end)
	throw NetworkError("Unexpected end of changeset (1)");

    if (valid) {
	// Check the revision number.
	// If the database was not known to be valid, we cannot
	// reliably determine its revision number, so must skip this
	// check.
	BrassRecordTable record_table(db_dir, true);
	record_table.open();
	if (startrev != record_table.get_open_revision_number())
	    throw NetworkError("Changeset supplied is for wrong revision number");
    }

    unsigned char changes_type = ptr[0];
    if (changes_type != 0) {
	throw NetworkError("Unsupported changeset type: " + str(changes_type));
	// FIXME - support changes of type 1, produced when DANGEROUS mode is
	// on.
    }

    // Clear the bits of the buffer which have been read.
    buf.erase(0, ptr + 1 - buf.data());

    // Read the items from the changeset.
    while (true) {
	conn.get_message_chunk(buf, REASONABLE_CHANGESET_SIZE, end_time);
	ptr = buf.data();
	end = ptr + buf.size();

	// Read the type of the next chunk of data
	if (ptr == end)
	    throw NetworkError("Unexpected end of changeset (2)");
	unsigned char chunk_type = ptr[0];
	++ptr;
	if (chunk_type == 0)
	    break;

	// Get the tablename.
	string tablename;
	if (!unpack_string(&ptr, end, tablename))
	    throw NetworkError("Unexpected end of changeset (3)");
	if (tablename.empty())
	    throw NetworkError("Missing tablename in changeset");
	if (tablename.find_first_not_of("abcdefghijklmnopqrstuvwxyz") !=
	    tablename.npos)
	    throw NetworkError("Invalid character in tablename in changeset");

	// Process the chunk
	if (ptr == end)
	    throw NetworkError("Unexpected end of changeset (4)");
	buf.erase(0, ptr - buf.data());

	switch (chunk_type) {
	    case 1:
		process_changeset_chunk_base(tablename, buf, conn, end_time);
		break;
	    case 2:
		process_changeset_chunk_blocks(tablename, buf, conn, end_time);
		break;
	    default:
		throw NetworkError("Unrecognised item type in changeset");
	}
    }
    brass_revision_number_t reqrev;
    if (!unpack_uint(&ptr, end, &reqrev))
	throw NetworkError("Couldn't read a valid required revision from changeset");
    if (reqrev < endrev)
	throw NetworkError("Required revision in changeset is earlier than end revision");
    if (ptr != end)
	throw NetworkError("Junk found at end of changeset");

    buf.resize(0);
    pack_uint(buf, reqrev);
    RETURN(buf);
}

string
BrassDatabaseReplicator::get_uuid() const
{
    LOGCALL(DB, string, "BrassDatabaseReplicator::get_uuid", NO_ARGS);
    BrassVersion version_file(db_dir);
    try {
	version_file.read_and_check();
    } catch (const Xapian::DatabaseError &) {
	RETURN(string());
    }
    RETURN(version_file.get_uuid_string());
}
