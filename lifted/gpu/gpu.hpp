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

#define SMEM_BYTE(seg, addr) ({    \
    uint16_t displ = (addr); \
    uintptr_t _seg = (seg);  \
    uintptr_t finalAddr = cpu->mem_base + (_seg * SEGM) + displ; \
    (uint8_t *)finalAddr; \
})[0]

#define SMEM_WORD(seg, addr) ({    \
    uint16_t displ = (addr); \
    uintptr_t _seg = (seg);  \
    uintptr_t finalAddr = cpu->mem_base + (_seg * SEGM) + displ; \
    (uint16_t *)finalAddr;   \
})[0]

#define SMEM_DWORD(seg, addr) ({   \
    uint16_t displ = (addr); \
    uintptr_t _seg = (seg);  \
    uintptr_t finalAddr = cpu->mem_base + (_seg * SEGM) + displ; \
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
#define INST_ROL(dest, src) ({dest = std::rotl(dest, src);})
#define INST_ROR(dest, src) ({dest = std::rotr(dest, src);})

#define INST_INC(dest) ({dest += 1;})
#define INST_DEC(dest) ({dest -= 1;})

#define INST_MOVZX(dest, src) ({dest = src;})

#define INST_CBW() ({cpu->AX = SIGNED(cpu->AL);})

#define INST_XOR(dest, src) ({dest ^= src;})
#define INST_AND(dest, src) ({dest &= src;})
#define INST_OR(dest, src)  ({dest |= src;})
#define INST_NOT(dest)  ({dest = ~dest;})

#define INST_XCHG(dest, src) ({ \
    auto tmp = src; \
    src = dest;     \
    dest = tmp;     \
})

#define INST_MOVSX(dest, src) ({dest = SIGNED(src);})

// we just ignore the direction flag, the code never sets it to reverse, thank God
#define INST_LODSB() ({ \
    cpu->AL = MEM_BYTE(cpu->SI); \
    cpu->SI += 1;                \
})
#define INST_LODSW() ({ \
    cpu->AX = MEM_WORD(cpu->SI); \
    cpu->SI += 2;                \
})
#define INST_LODSD() ({   \
    cpu->EAX = MEM_DWORD(cpu->SI); \
    cpu->SI += 4;                  \
})

#define INST_STOSB() ({ \
    SMEM_BYTE(cpu->ES, cpu->DI) = cpu->AL; \
    cpu->DI += 1;       \
})
#define INST_STOSW() ({ \
    SMEM_WORD(cpu->ES, cpu->DI) = cpu->AX; \
    cpu->DI += 2;       \
})
#define INST_STOSD() ({   \
    SMEM_DWORD(cpu->ES, cpu->DI) = cpu->EAX; \
    cpu->DI += 4;         \
})

#define INST_MOVSD() ({ \
    SMEM_DWORD(cpu->ES, cpu->DI) = MEM_DWORD(cpu->SI); \
    cpu->SI += 4; \
    cpu->DI += 4; \
})

#define INST_CWD() ({ \
    if(cpu->AX & 0x8000){ \
        cpu->DX = 0xFFFF; \
    }else{                \
        cpu->DX = 0;      \
    }                     \
})

#define INST_CDQ() ({ \
    if(cpu->EAX & 0x80000000){ \
        cpu->EDX = 0xFFFFFFFF; \
    }else{                \
        cpu->EDX = 0;     \
    }                     \
})

#define INST_XLAT() ({cpu->AL = MEM_BYTE(cpu->BX + cpu->AL);})

#define INST_MUL(op) ({    \
    static_assert(sizeof(op) == 2, "We only support 16bit for this instruction"); \
    uint32_t res = (uint32_t)cpu->AX * (uint32_t)op; \
    cpu->AX = res & 0xffff; \
    cpu->DX = res >> 16;    \
})


static inline void inner_imul(cpu_ctx *cpu, uint16_t a){
    auto as = SIGNED(a);
    auto sax = SIGNED(cpu->AX);

    auto res = (int32_t)sax * (int32_t)as;
    cpu->AX = res & 0xffff;
    cpu->DX = res >> 16;
}
static inline void inner_imul(cpu_ctx *cpu, uint32_t a, uint32_t b){
    auto as = SIGNED(a);
    auto bs = SIGNED(b);

    auto res = (int64_t)as * (int64_t)bs;
    cpu->EAX = res & 0xffffffff;
    cpu->EDX = res >> 32;
}

#define INST_IMUL(...) inner_imul(cpu,__VA_ARGS__)

#define INST_CLC() ({cpu->CF = 0;})






