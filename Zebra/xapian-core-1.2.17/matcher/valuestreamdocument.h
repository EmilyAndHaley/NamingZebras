/** @file valuestreamdocument.h
 * @brief A document which gets its values from a ValueStreamManager.
 */
/* Copyright (C) 2009 Olly Betts
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

#ifndef XAPIAN_INCLUDED_VALUESTREAMDOCUMENT_H
#define XAPIAN_INCLUDED_VALUESTREAMDOCUMENT_H

#include "document.h"
#include "valuelist.h"
#include "xapian/types.h"

#include <map>

/// A document which gets its values from a ValueStreamManager.
class ValueStreamDocument : public Xapian::Document::Internal {
    /// Don't allow assignment.
    void operator=(const ValueStreamDocument &);

    /// Don't allow copying.
    ValueStreamDocument(const ValueStreamDocument &);

    mutable std::map<Xapian::valueno, ValueList *> valuelists;

    Xapian::Database db;

    size_t current;

    mutable Xapian::Document::Internal * doc;

  public:
    ValueStreamDocument(const Xapian::Database & db_)
       	: Internal(db_.internal[0], 0), db(db_), current(0), doc(NULL) { }

    void new_subdb(int n);

    ~ValueStreamDocument();

    void set_document(Xapian::docid did_) {
	did = did_;
	delete doc;
	doc = NULL;
    }

    // Optimise away the virtual call when the matcher wants to know a value.
    string get_value(Xapian::valueno slot) const {
	return ValueStreamDocument::do_get_value(slot);
    }

  private:
    /** Implementation of virtual methods @{ */
    string do_get_value(Xapian::valueno slot) const;
    void do_get_all_values(map<Xapian::valueno, string> & values_) const;
    string do_get_data() const;
    /** @} */
};

#endif // XAPIAN_INCLUDED_VALUESTREAMDOCUMENT_H
