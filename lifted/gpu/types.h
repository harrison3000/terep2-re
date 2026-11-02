#pragma once

#include <stdint.h>
#include "../variables.h"

//TODO configure in the build scripts
#define T_MAX_H 910

typedef struct {
    // GPRs
    union {uint32_t EAX;  uint16_t AX;  struct { uint8_t AL, AH; }; };
    union {uint32_t EBX;  uint16_t BX;  struct { uint8_t BL, BH; }; };
    union {uint32_t ECX;  uint16_t CX;  struct { uint8_t CL, CH; }; };
    union {uint32_t EDX;  uint16_t DX;  struct { uint8_t DL, DH; }; };

    uint16_t SI;
    uint16_t DI;
    
    union {uint32_t EBP;  uint16_t BP; };

    uint8_t padding[7];//premature optimization for pushad/popad to be exacly 8*4
    uint8_t CF;

    //segment registers, will be a index in the segments array above
    uint16_t DS; //should ALWAYS be zero
    uint16_t ES, FS, GS;

    uintptr_t mem_base;
    uintptr_t segments[11];//10 should be enough for a track with 5 cars with different textures +1 for safety

    struct otherVars vars;

    //this will be given to the outside world, so its better to be a pointer than embeded directly in this struct
    uint8_t *framebuffer;

    uintptr_t extra_data;

    uint32_t vp_w, vp_h;
    int32_t mult; // resolution multiplier
    bool s_original;
    uint16_t bunchOfInts[T_MAX_H*2*3];
} cpu_ctx;