/* This file was generated automatically by the Snowball to ISO C++ compiler */

#include "steminternal.h"

namespace Xapian {

class InternalStemFrench : public SnowballStemImplementation {
    int I_p2;
    int I_p1;
    int I_pV;
  public:
    int r_un_accent();
    int r_un_double();
    int r_residual_suffix();
    int r_verb_suffix();
    int r_i_verb_suffix();
    int r_standard_suffix();
    int r_R2();
    int r_R1();
    int r_RV();
    int r_mark_regions();
    int r_postlude();
    int r_prelude();

    InternalStemFrench();
    ~InternalStemFrench();
    int stem();
    std::string get_description() const;
};

}
