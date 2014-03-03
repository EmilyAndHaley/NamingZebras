/* This file was generated automatically by the Snowball to ISO C++ compiler */

#include "steminternal.h"

namespace Xapian {

class InternalStemPorter : public SnowballStemImplementation {
    unsigned char B_Y_found;
    int I_p2;
    int I_p1;
  public:
    int r_Step_5b();
    int r_Step_5a();
    int r_Step_4();
    int r_Step_3();
    int r_Step_2();
    int r_Step_1c();
    int r_Step_1b();
    int r_Step_1a();
    int r_R2();
    int r_R1();
    int r_shortv();

    InternalStemPorter();
    ~InternalStemPorter();
    int stem();
    std::string get_description() const;
};

}
