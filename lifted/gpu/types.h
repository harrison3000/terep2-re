#pragma once

#include <stdint.h>

typedef struct otherVars otherVars;

typedef struct {
    // GPRs
    union {uint32_t EAX;  uint16_t AX;  struct { uint8_t AL, AH; }; };
    union {uint32_t EBX;  uint16_t BX;  struct { uint8_t BL, BH; }; };
    union {uint32_t ECX;  uint16_t CX;  struct { uint8_t CL, CH; }; };
    union {uint32_t EDX;  uint16_t DX;  struct { uint8_t DL, DH; }; };

    uint16_t SI;
    uint16_t DI;
    
    union {uint32_t EBP;  uint16_t BP; };

    uint32_t padding;//premature optimization for pushad/popad to be exacly 8*4
    uint32_t padding2;

    uintptr_t mem_base;
    uintptr_t segments[16];

    //segment registers, will be a index in the segments array above
    uint16_t DS; //should ALWAYS be zero
    uint16_t ES, FS, GS;

    uint8_t CF;

    otherVars *vars;

    int double_res;

    uint8_t *framebuffer;

    uintptr_t extra_data;
} cpu_ctx;