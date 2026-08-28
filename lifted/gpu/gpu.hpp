//GPU stands for Gambiarra Processing Unit :)
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
    union {uint32_t ESP;  uint16_t SP; };

    //segment registers, will be used with a multiplier (1024, not 16 like in the original real mode) to fake segments
    uint16_t DS; //should ALWAYS be zero
    uint16_t CS; //should never be used
    uint16_t ES, FS, GS;

    uintptr_t mem_base;

    std::vector<stackItem> stack;


    //TODO flags! that cant be done with last res
};


#define INST_PUSH(reg) cpu->stack.push_back({.value = reg, .line = __LINE__, .size = sizeof(reg)});

#define INST_POP(reg) ({        \
    auto it = cpu->stack.back();\
    if(sizeof(reg) != it.size){__builtin_trap();}\
    cpu->stack.pop_back();      \
    reg = it.value;             \
})


#define MEM_BYTE(addr) ({ \
    uintptr_t displ = cpu->mem_base + addr; \
    (uint8_t *)displ; \
})[0]

#define MEM_WORD(addr) ({ \
    uintptr_t displ = cpu->mem_base + addr; \
    (uint16_t *)displ; \
})[0]

#define MEM_DWORD(addr) ({ \
    uintptr_t displ = cpu->mem_base + addr; \
    (uint32_t *)displ; \
})[0]

inline int8_t SIGNED(uint8_t v) { return v; }
inline int16_t SIGNED(uint16_t v) { return v; }
inline int32_t SIGNED(uint32_t v) { return v; } 

//the builtin is the oposite of the x86 flag
#define PARITY(val) (!__builtin_parity(val))

//TODO implement
#define DOS3Call(cpu) ({})

#define INST_ADD(dest, src) ({dest += src;})
#define INST_NEG(dest) ({ \
    auto ds = SIGNED(dest);\
    dest = ds; \
})
#define INST_SHL(dest, src) ({dest <<= src;})