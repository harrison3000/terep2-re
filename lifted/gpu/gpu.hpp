//GPU stands for Gambiarra Processing Unit :)
#pragma once

#include <cstdint>

#include "types.hpp"

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

static inline int8_t SIGNED(uint8_t v) { return v; }
static inline int16_t SIGNED(uint16_t v) { return v; }
static inline int32_t SIGNED(uint32_t v) { return v; }

static inline int msbset(uint8_t v)  { return (v & 0x80) != 0 ; }
static inline int msbset(uint16_t v) { return (v & 0x8000) != 0 ; }
static inline int msbset(uint32_t v) { return (v & 0x80000000) != 0 ; }

#define UPDATE_ZPF(val)({ \
    cpu->flagtrio = 0;    \
    cpu->ZF = val == 0;   \
    cpu->SF = msbset(val);\
    /*the builtin is the oposite of the x86 flag*/ \
    cpu->PF = !__builtin_parity(val); \
})


