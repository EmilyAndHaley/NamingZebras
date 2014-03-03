/* chert_types.h: Types used by chert backend and the Btree manager
 *
 * Copyright 1999,2000,2001 BrightStation PLC
 * Copyright 2002,2003,2004,2008,2009 Olly Betts
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

#ifndef OM_HGUARD_CHERT_TYPES_H
#define OM_HGUARD_CHERT_TYPES_H

#include "internaltypes.h"

typedef unsigned int chert_blocksize_t;

/** A type used to store a revision number for a table.
 *
 *  A table's revision number increases monotonically, incrementing by
 *  one each time a modification is applied to the table.
 *
 *  FIXME: ensure that this is of a suitable minimum size - 32 bits is
 *  satisfactory in most cases, but in extreme cases could cause the revision
 *  number to roll over after a few years.  It would be better to use 64 bits
 *  (and / or to ensure that rolling over causes no problem).
 */
typedef unsigned int chert_revision_number_t;

/** A type used to store the number of entries in a table.
 *
 *  Again, this must be of suitable minimum size.
 */
typedef unsigned long long chert_tablesize_t;

/** An integer type for storing the length of a document - ie, the sum of the
 *  wdfs of the terms in the document.
 */
typedef unsigned int chert_doclen_t;

/** The default block size to use in a B-tree table.
 *  If this is changed, be sure to update the API documentation
 *  correspondingly.
 */
#define CHERT_DEFAULT_BLOCK_SIZE 8192

#endif /* OM_HGUARD_CHERT_TYPES_H */
