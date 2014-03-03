/* This file was generated automatically by the Snowball to ISO C++ compiler */

#include <limits.h>
#include "german.h"

static const symbol s_pool[] = {
#define s_0_1 0
'U',
#define s_0_2 1
'Y',
#define s_0_3 2
0xC3, 0xA4,
#define s_0_4 4
0xC3, 0xB6,
#define s_0_5 6
0xC3, 0xBC,
#define s_1_0 s_1_1
#define s_1_1 8
'e', 'm',
#define s_1_2 10
'e', 'n',
#define s_1_3 12
'e', 'r', 'n',
#define s_1_4 s_1_3
#define s_1_5 (s_1_6 + 1)
#define s_1_6 15
'e', 's',
#define s_2_0 17
'e', 'n',
#define s_2_1 19
'e', 'r',
#define s_2_2 (s_2_3 + 1)
#define s_2_3 21
'e', 's', 't',
#define s_3_0 24
'i', 'g',
#define s_3_1 26
'l', 'i', 'c', 'h',
#define s_4_0 30
'e', 'n', 'd',
#define s_4_1 33
'i', 'g',
#define s_4_2 35
'u', 'n', 'g',
#define s_4_3 38
'l', 'i', 'c', 'h',
#define s_4_4 42
'i', 's', 'c', 'h',
#define s_4_5 46
'i', 'k',
#define s_4_6 48
'h', 'e', 'i', 't',
#define s_4_7 52
'k', 'e', 'i', 't',
};


static const struct among a_0[6] =
{
/*  0 */ { 0, 0, -1, 6},
/*  1 */ { 1, s_0_1, 0, 2},
/*  2 */ { 1, s_0_2, 0, 1},
/*  3 */ { 2, s_0_3, 0, 3},
/*  4 */ { 2, s_0_4, 0, 4},
/*  5 */ { 2, s_0_5, 0, 5}
};


static const struct among a_1[7] =
{
/*  0 */ { 1, s_1_0, -1, 2},
/*  1 */ { 2, s_1_1, -1, 1},
/*  2 */ { 2, s_1_2, -1, 2},
/*  3 */ { 3, s_1_3, -1, 1},
/*  4 */ { 2, s_1_4, -1, 1},
/*  5 */ { 1, s_1_5, -1, 3},
/*  6 */ { 2, s_1_6, 5, 2}
};


static const struct among a_2[4] =
{
/*  0 */ { 2, s_2_0, -1, 1},
/*  1 */ { 2, s_2_1, -1, 1},
/*  2 */ { 2, s_2_2, -1, 2},
/*  3 */ { 3, s_2_3, 2, 1}
};


static const struct among a_3[2] =
{
/*  0 */ { 2, s_3_0, -1, 1},
/*  1 */ { 4, s_3_1, -1, 1}
};


static const struct among a_4[8] =
{
/*  0 */ { 3, s_4_0, -1, 1},
/*  1 */ { 2, s_4_1, -1, 2},
/*  2 */ { 3, s_4_2, -1, 1},
/*  3 */ { 4, s_4_3, -1, 3},
/*  4 */ { 4, s_4_4, -1, 2},
/*  5 */ { 2, s_4_5, -1, 2},
/*  6 */ { 4, s_4_6, -1, 3},
/*  7 */ { 4, s_4_7, -1, 4}
};

static const unsigned char g_v[] = { 17, 65, 16, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 32, 8 };

static const unsigned char g_s_ending[] = { 117, 30, 5 };

static const unsigned char g_st_ending[] = { 117, 30, 4 };

static const symbol s_0[] = { 0xC3, 0x9F };
static const symbol s_1[] = { 's', 's' };
static const symbol s_2[] = { 'U' };
static const symbol s_3[] = { 'Y' };
static const symbol s_4[] = { 'y' };
static const symbol s_5[] = { 'u' };
static const symbol s_6[] = { 'a' };
static const symbol s_7[] = { 'o' };
static const symbol s_8[] = { 'u' };
static const symbol s_9[] = { 'n', 'i', 's' };
static const symbol s_10[] = { 'i', 'g' };
static const symbol s_11[] = { 'e', 'r' };
static const symbol s_12[] = { 'e', 'n' };

int Xapian::InternalStemGerman::r_prelude() { /* forwardmode */
    {   int c_test1 = c; /* test, line 35 */
        while(1) { /* repeat, line 35 */
            int c2 = c;
            {   int c3 = c; /* or, line 38 */
                bra = c; /* [, line 37 */
                if (!(eq_s(2, s_0))) goto lab2; /* literal, line 37 */
                ket = c; /* ], line 37 */
                {   int ret = slice_from_s(2, s_1); /* <-, line 37 */
                    if (ret < 0) return ret;
                }
                goto lab1;
            lab2:
                c = c3;
                {   int ret = skip_utf8(p, c, 0, l, 1);
                    if (ret < 0) goto lab0;
                    c = ret; /* next, line 38 */
                }
            }
        lab1:
            continue;
        lab0:
            c = c2;
            break;
        }
        c = c_test1;
    }
    while(1) { /* repeat, line 41 */
        int c4 = c;
        while(1) { /* goto, line 41 */
            int c5 = c;
            if (in_grouping_U(g_v, 97, 252, 0)) goto lab4; /* grouping v, line 42 */
            bra = c; /* [, line 42 */
            {   int c6 = c; /* or, line 42 */
                if (c == l || p[c] != 'u') goto lab6;
                c++;
                ket = c; /* ], line 42 */
                if (in_grouping_U(g_v, 97, 252, 0)) goto lab6; /* grouping v, line 42 */
                {   int ret = slice_from_s(1, s_2); /* <-, line 42 */
                    if (ret < 0) return ret;
                }
                goto lab5;
            lab6:
                c = c6;
                if (c == l || p[c] != 'y') goto lab4;
                c++;
                ket = c; /* ], line 43 */
                if (in_grouping_U(g_v, 97, 252, 0)) goto lab4; /* grouping v, line 43 */
                {   int ret = slice_from_s(1, s_3); /* <-, line 43 */
                    if (ret < 0) return ret;
                }
            }
        lab5:
            c = c5;
            break;
        lab4:
            c = c5;
            {   int ret = skip_utf8(p, c, 0, l, 1);
                if (ret < 0) goto lab3;
                c = ret; /* goto, line 41 */
            }
        }
        continue;
    lab3:
        c = c4;
        break;
    }
    return 1;
}

int Xapian::InternalStemGerman::r_mark_regions() { /* forwardmode */
    I_p1 = l; /* p1 = <integer expression>, line 49 */
    I_p2 = l; /* p2 = <integer expression>, line 50 */
    {   int c_test1 = c; /* test, line 52 */
        {   int ret = skip_utf8(p, c, 0, l, + 3); /* hop, line 52 */
            if (ret < 0) return 0;
            c = ret;
        }
        I_x = c; /* setmark x, line 52 */
        c = c_test1;
    }
    {   int ret = out_grouping_U(g_v, 97, 252, 1); /* gopast */ /* grouping v, line 54 */
        if (ret < 0) return 0;
        c += ret;
    }
    {   int ret = in_grouping_U(g_v, 97, 252, 1); /* gopast */ /* non v, line 54 */
        if (ret < 0) return 0;
        c += ret;
    }
    I_p1 = c; /* setmark p1, line 54 */
    /* try, line 55 */
    if (!(I_p1 < I_x)) goto lab0; /* p1 < <integer expression>, line 55 */
    I_p1 = I_x; /* p1 = <integer expression>, line 55 */
lab0:
    {   int ret = out_grouping_U(g_v, 97, 252, 1); /* gopast */ /* grouping v, line 56 */
        if (ret < 0) return 0;
        c += ret;
    }
    {   int ret = in_grouping_U(g_v, 97, 252, 1); /* gopast */ /* non v, line 56 */
        if (ret < 0) return 0;
        c += ret;
    }
    I_p2 = c; /* setmark p2, line 56 */
    return 1;
}

int Xapian::InternalStemGerman::r_postlude() { /* forwardmode */
    int among_var;
    while(1) { /* repeat, line 60 */
        int c1 = c;
        bra = c; /* [, line 62 */
        among_var = find_among(s_pool, a_0, 6, 0, 0); /* substring, line 62 */
        if (!(among_var)) goto lab0;
        ket = c; /* ], line 62 */
        switch(among_var) { /* among, line 62 */
            case 0: goto lab0;
            case 1:
                {   int ret = slice_from_s(1, s_4); /* <-, line 63 */
                    if (ret < 0) return ret;
                }
                break;
            case 2:
                {   int ret = slice_from_s(1, s_5); /* <-, line 64 */
                    if (ret < 0) return ret;
                }
                break;
            case 3:
                {   int ret = slice_from_s(1, s_6); /* <-, line 65 */
                    if (ret < 0) return ret;
                }
                break;
            case 4:
                {   int ret = slice_from_s(1, s_7); /* <-, line 66 */
                    if (ret < 0) return ret;
                }
                break;
            case 5:
                {   int ret = slice_from_s(1, s_8); /* <-, line 67 */
                    if (ret < 0) return ret;
                }
                break;
            case 6:
                {   int ret = skip_utf8(p, c, 0, l, 1);
                    if (ret < 0) goto lab0;
                    c = ret; /* next, line 68 */
                }
                break;
        }
        continue;
    lab0:
        c = c1;
        break;
    }
    return 1;
}

int Xapian::InternalStemGerman::r_R1() { /* backwardmode */
    if (!(I_p1 <= c)) return 0; /* p1 <= <integer expression>, line 75 */
    return 1;
}

int Xapian::InternalStemGerman::r_R2() { /* backwardmode */
    if (!(I_p2 <= c)) return 0; /* p2 <= <integer expression>, line 76 */
    return 1;
}

int Xapian::InternalStemGerman::r_standard_suffix() { /* backwardmode */
    int among_var;
    {   int m1 = l - c; (void)m1; /* do, line 79 */
        ket = c; /* [, line 80 */
        if (c <= lb || p[c - 1] >> 5 != 3 || !((811040 >> (p[c - 1] & 0x1f)) & 1)) goto lab0; /* substring, line 80 */
        among_var = find_among_b(s_pool, a_1, 7, 0, 0);
        if (!(among_var)) goto lab0;
        bra = c; /* ], line 80 */
        {   int ret = r_R1(); /* call R1, line 80 */
            if (ret == 0) goto lab0;
            if (ret < 0) return ret;
        }
        switch(among_var) { /* among, line 80 */
            case 0: goto lab0;
            case 1:
                if (slice_del() == -1) return -1; /* delete, line 82 */
                break;
            case 2:
                if (slice_del() == -1) return -1; /* delete, line 85 */
                {   int m2 = l - c; (void)m2; /* try, line 86 */
                    ket = c; /* [, line 86 */
                    if (c <= lb || p[c - 1] != 's') { c = l - m2; goto lab1; }
                    c--;
                    bra = c; /* ], line 86 */
                    if (!(eq_s_b(3, s_9))) { c = l - m2; goto lab1; } /* literal, line 86 */
                    if (slice_del() == -1) return -1; /* delete, line 86 */
                lab1:
                    ;
                }
                break;
            case 3:
                if (in_grouping_b_U(g_s_ending, 98, 116, 0)) goto lab0; /* grouping s_ending, line 89 */
                if (slice_del() == -1) return -1; /* delete, line 89 */
                break;
        }
    lab0:
        c = l - m1;
    }
    {   int m3 = l - c; (void)m3; /* do, line 93 */
        ket = c; /* [, line 94 */
        if (c - 1 <= lb || p[c - 1] >> 5 != 3 || !((1327104 >> (p[c - 1] & 0x1f)) & 1)) goto lab2; /* substring, line 94 */
        among_var = find_among_b(s_pool, a_2, 4, 0, 0);
        if (!(among_var)) goto lab2;
        bra = c; /* ], line 94 */
        {   int ret = r_R1(); /* call R1, line 94 */
            if (ret == 0) goto lab2;
            if (ret < 0) return ret;
        }
        switch(among_var) { /* among, line 94 */
            case 0: goto lab2;
            case 1:
                if (slice_del() == -1) return -1; /* delete, line 96 */
                break;
            case 2:
                if (in_grouping_b_U(g_st_ending, 98, 116, 0)) goto lab2; /* grouping st_ending, line 99 */
                {   int ret = skip_utf8(p, c, lb, l, - 3); /* hop, line 99 */
                    if (ret < 0) goto lab2;
                    c = ret;
                }
                if (slice_del() == -1) return -1; /* delete, line 99 */
                break;
        }
    lab2:
        c = l - m3;
    }
    {   int m4 = l - c; (void)m4; /* do, line 103 */
        ket = c; /* [, line 104 */
        if (c - 1 <= lb || p[c - 1] >> 5 != 3 || !((1051024 >> (p[c - 1] & 0x1f)) & 1)) goto lab3; /* substring, line 104 */
        among_var = find_among_b(s_pool, a_4, 8, 0, 0);
        if (!(among_var)) goto lab3;
        bra = c; /* ], line 104 */
        {   int ret = r_R2(); /* call R2, line 104 */
            if (ret == 0) goto lab3;
            if (ret < 0) return ret;
        }
        switch(among_var) { /* among, line 104 */
            case 0: goto lab3;
            case 1:
                if (slice_del() == -1) return -1; /* delete, line 106 */
                {   int m5 = l - c; (void)m5; /* try, line 107 */
                    ket = c; /* [, line 107 */
                    if (!(eq_s_b(2, s_10))) { c = l - m5; goto lab4; } /* literal, line 107 */
                    bra = c; /* ], line 107 */
                    {   int m6 = l - c; (void)m6; /* not, line 107 */
                        if (c <= lb || p[c - 1] != 'e') goto lab5;
                        c--;
                        { c = l - m5; goto lab4; }
                    lab5:
                        c = l - m6;
                    }
                    {   int ret = r_R2(); /* call R2, line 107 */
                        if (ret == 0) { c = l - m5; goto lab4; }
                        if (ret < 0) return ret;
                    }
                    if (slice_del() == -1) return -1; /* delete, line 107 */
                lab4:
                    ;
                }
                break;
            case 2:
                {   int m7 = l - c; (void)m7; /* not, line 110 */
                    if (c <= lb || p[c - 1] != 'e') goto lab6;
                    c--;
                    goto lab3;
                lab6:
                    c = l - m7;
                }
                if (slice_del() == -1) return -1; /* delete, line 110 */
                break;
            case 3:
                if (slice_del() == -1) return -1; /* delete, line 113 */
                {   int m8 = l - c; (void)m8; /* try, line 114 */
                    ket = c; /* [, line 115 */
                    {   int m9 = l - c; (void)m9; /* or, line 115 */
                        if (!(eq_s_b(2, s_11))) goto lab9; /* literal, line 115 */
                        goto lab8;
                    lab9:
                        c = l - m9;
                        if (!(eq_s_b(2, s_12))) { c = l - m8; goto lab7; } /* literal, line 115 */
                    }
                lab8:
                    bra = c; /* ], line 115 */
                    {   int ret = r_R1(); /* call R1, line 115 */
                        if (ret == 0) { c = l - m8; goto lab7; }
                        if (ret < 0) return ret;
                    }
                    if (slice_del() == -1) return -1; /* delete, line 115 */
                lab7:
                    ;
                }
                break;
            case 4:
                if (slice_del() == -1) return -1; /* delete, line 119 */
                {   int m10 = l - c; (void)m10; /* try, line 120 */
                    ket = c; /* [, line 121 */
                    if (c - 1 <= lb || (p[c - 1] != 103 && p[c - 1] != 104)) { c = l - m10; goto lab10; } /* substring, line 121 */
                    among_var = find_among_b(s_pool, a_3, 2, 0, 0);
                    if (!(among_var)) { c = l - m10; goto lab10; }
                    bra = c; /* ], line 121 */
                    {   int ret = r_R2(); /* call R2, line 121 */
                        if (ret == 0) { c = l - m10; goto lab10; }
                        if (ret < 0) return ret;
                    }
                    switch(among_var) { /* among, line 121 */
                        case 0: { c = l - m10; goto lab10; }
                        case 1:
                            if (slice_del() == -1) return -1; /* delete, line 123 */
                            break;
                    }
                lab10:
                    ;
                }
                break;
        }
    lab3:
        c = l - m4;
    }
    return 1;
}

int Xapian::InternalStemGerman::stem() { /* forwardmode */
    {   int c1 = c; /* do, line 134 */
        {   int ret = r_prelude(); /* call prelude, line 134 */
            if (ret == 0) goto lab0;
            if (ret < 0) return ret;
        }
    lab0:
        c = c1;
    }
    {   int c2 = c; /* do, line 135 */
        {   int ret = r_mark_regions(); /* call mark_regions, line 135 */
            if (ret == 0) goto lab1;
            if (ret < 0) return ret;
        }
    lab1:
        c = c2;
    }
    lb = c; c = l; /* backwards, line 136 */

    {   int m3 = l - c; (void)m3; /* do, line 137 */
        {   int ret = r_standard_suffix(); /* call standard_suffix, line 137 */
            if (ret == 0) goto lab2;
            if (ret < 0) return ret;
        }
    lab2:
        c = l - m3;
    }
    c = lb;
    {   int c4 = c; /* do, line 138 */
        {   int ret = r_postlude(); /* call postlude, line 138 */
            if (ret == 0) goto lab3;
            if (ret < 0) return ret;
        }
    lab3:
        c = c4;
    }
    return 1;
}

Xapian::InternalStemGerman::InternalStemGerman()
    : I_x(0), I_p2(0), I_p1(0)
{
}

Xapian::InternalStemGerman::~InternalStemGerman()
{
}

std::string
Xapian::InternalStemGerman::get_description() const
{
    return "german";
}
