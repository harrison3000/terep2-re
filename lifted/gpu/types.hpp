#pragma once

#include <cstdint>
#include <vector>

struct stackItem {
    uint32_t value;  uint16_t line; uint16_t size;
};

struct cpu_ctx {
    // GPRs
    union {uint32_t EAX;  uint16_t AX;  struct { uint8_t AL, AH; }; };
    union {uint32_t EBX;  uint16_t BX;  struct { uint8_t BL, BH; }; };
    union {uint32_t ECX;  uint16_t CX;  struct { uint8_t CL, CH; }; };
    union {uint32_t EDX;  uint16_t DX;  struct { uint8_t DL, DH; }; };


    union {uint32_t ESI;  uint16_t SI; };
    union {uint32_t EDI;  uint16_t DI; };
    
    union {uint32_t EBP;  uint16_t BP; };

    //segment registers, will be used with a multiplier to emulate segments
    //(defined below, not exactly 16 like in the original real mode) 
    uint16_t DS; //should ALWAYS be zero
    uint16_t CS; //should never be used
    uint16_t ES, FS, GS;

    uint8_t CF;

    uintptr_t mem_base;

    std::vector<stackItem> stack;
};