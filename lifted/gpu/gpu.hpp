//GPU stands for Gambiarra Processing Unit :)
#pragma once

#include <cstdint>
#include <vector>
#include <bit>
#include <cstdio>

#include "types.hpp"

//TODO add a 4k buffer zone so we can fault on writes beyond 64k?
//or maybe just use the blinkenlights to see rogue writes
#define SEGM 1024

#define def_datareg 0

#define INST_PUSH(reg) cpu->stack.push_back({.value = reg, .line = __LINE__, .size = sizeof(reg)});

#define INST_POP(reg) ({        \
    auto it = cpu->stack.back();\
    if(sizeof(reg) != it.size){__builtin_trap();}\
    cpu->stack.pop_back();      \
    reg = it.value;             \
})

#define DUMMY_POP_WORD() ({ \
    int16_t dummy;   \
    INST_POP(dummy); \
})

#define MEM_BYTE(addr) ({    \
    uint16_t displ = (addr); \
    uintptr_t finalAddr = cpu->mem_base + displ; \
    (uint8_t *)finalAddr; \
})[0]

#define MEM_WORD(addr) ({    \
    uint16_t displ = (addr); \
    uintptr_t finalAddr = cpu->mem_base + displ; \
    (uint16_t *)finalAddr;   \
})[0]

#define MEM_DWORD(addr) ({   \
    uint16_t displ = (addr); \
    uintptr_t finalAddr = cpu->mem_base + displ; \
    (uint32_t *)finalAddr;   \
})[0]

inline int8_t SIGNED(uint8_t v) { return v; }
inline int16_t SIGNED(uint16_t v) { return v; }
inline int32_t SIGNED(uint32_t v) { return v; } 

//the builtin is the oposite of the x86 flag
#define PARITY(val) (!__builtin_parity(val))

//TODO improve
#define CHECK_CFLAG() cpu->CF

void DOS3Call(cpu_ctx*);

#define INST_NOP() ({})

#define INST_ADD(dest, src) ({dest += src;})
#define INST_SUB(dest, src) ({dest -= src;})

#define INST_NEG(dest) ({ \
    typeof(dest) ds = 0 - dest;\
    dest = ds; \
})

#define INST_SHL(dest, src) ({dest <<= src;})
#define INST_SHR(dest, src) ({dest >>= src;})
#define INST_SAR(dest, src) ({ \
    typeof(dest) ds = SIGNED(dest);\
    ds >>= src; \
    dest = ds;  \
})

#define INST_INC(dest) ({dest += 1;})
#define INST_DEC(dest) ({dest -= 1;})

#define INST_MOVZX(dest, src) ({dest = src;})


