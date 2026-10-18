#pragma once

#include "gpu/types.hpp"
#include <cstdint>

struct otherVars {
    uint16_t CSD_WORD_1000_0e67;

    uint32_t CSD_DWORD_1000_129f;
        
    uint32_t CSD_DWORD_1000_12a3 = 0x7FFF0000;
    uint32_t CSD_DWORD_1000_12a7;
    uint32_t CSD_DWORD_1000_12ab;
    uint32_t CSD_DWORD_1000_12af;
    uint32_t CSD_DWORD_1000_12b3;
    uint32_t CSD_DWORD_1000_12b7;
    uint32_t CSD_DWORD_1000_12bb;
    uint32_t CSD_DWORD_1000_12bf;
    uint32_t CSD_DWORD_1000_12c3;
    uint32_t CSD_DWORD_1000_12c7;

    uint8_t CSD_BYTE_1000_553e;

    uint8_t CSD_DAT_unk_592c[128];

    uint8_t giracor;
    uint8_t CSD_DAT_keys_571e[128];

    uint8_t CSD_BYTE_1000_59c1 = 0xf;

    uint16_t pseudolocal_a;
    uint16_t pseudolocal_b;

    uint16_t pseudolocal_2_a;

    uint8_t  mu_b_tmp;
    uint16_t mu_w_tmp;
    uint32_t mu_d_tmp;

    uint16_t retval_2418;


    //this used to be at 0x5ee, but it was bugged I think, it stored and loaded to AL, but used SAHF/LAHF (they modify AH), so yeah
    //and only worked because nothing overwrote AH in the meantime? IDK really
    //I will just make something that resembles what was probably intended and hope for the best
    //after the changes I didnt notice any rendering bug, so yeah
    uint8_t some_flag_thing_idk;

    uint8_t another_flag_thing;

    uint8_t flying_car_tmp;

    uint8_t another_quick_temp;
    uint16_t another_quick_temp_w;


    uint32_t mitemp_01;
    uint32_t mitemp_02;
    uint16_t mitemp_03;


    uint16_t v_tmp_26dd_a;
    uint16_t v_tmp_26dd_b;


    uint32_t pslc_eb5f;
    uint32_t pslc_ea9b;
    uint32_t pslc_eb63;

    uint32_t pslc_ea9f;
    uint32_t pslc_eb5b;
    uint32_t pslc_eaa3;

    uint32_t mitemp_BeX;

    uint16_t v_upper_si;
    uint16_t v_upper_di;

    uint32_t v_tmp_379b;
};