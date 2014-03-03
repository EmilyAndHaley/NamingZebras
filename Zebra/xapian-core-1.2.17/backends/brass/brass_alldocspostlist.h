/** @file brass_alldocspostlist.h
 * @brief A PostList which iterates over all documents in a BrassDatabase.
 */
/* Copyright (C) 2006,2007,2008,2009 Olly Betts
 * Copyright (C) 2008 Lemur Consulting Ltd
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
 */

#ifndef XAPIAN_INCLUDED_BRASS_ALLDOCSPOSTLIST_H
#define XAPIAN_INCLUDED_BRASS_ALLDOCSPOSTLIST_H

#include <string>

#include "brass_postlist.h"

class BrassAllDocsPostList : public BrassPostList {
    /// Don't allow assignment.
    void operator=(const BrassAllDocsPostList &);

    /// Don't allow copying.
    BrassAllDocsPostList(const BrassAllDocsPostList &);

    /// The number of documents in the database.
    Xapian::doccount doccount;

  public:
    BrassAllDocsPostList(Xapian::Internal::RefCntPtr<const BrassDatabase> db_,
			 Xapian::doccount doccount_);

    Xapian::doccount get_termfreq() const;

    Xapian::termcount get_doclength() const;

    Xapian::termcount get_wdf() const;

    PositionList *read_position_list();

    PositionList *open_position_list() const;

    std::string get_description() const;
};

#endif // XAPIAN_INCLUDED_BRASS_ALLDOCSPOSTLIST_H
