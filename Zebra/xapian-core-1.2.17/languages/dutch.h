/* This file was generated automatically by the Snowball to ISO C++ compiler */

#include "steminternal.h"

namespace Xapian {

class InternalStemDutch : public SnowballStemImplementation {
    int I_p2;
    int I_p1;
    unsigned char B_e_found;
  public:
    int r_standard_suffix();
    int r_undouble();
    int r_R2();
    int r_R1();
    int r_mark_regions();
    int r_en_ending();
    int r_e_ending();
    int r_postlude();
    int r_prelude();

    InternalStemDutch();
    ~InternalStemDutch();
    int stem();
    std::string get_description() const;
};

}
