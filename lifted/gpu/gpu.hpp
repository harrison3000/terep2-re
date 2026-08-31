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
    cpu->PF = !__builtin_parity(val & 0xff); \
})


void DOS3Call(cpu_ctx*);

#define INST_NOP() ({})

#define INST_ADD(_dest, src) ({ \
    auto &dest = (_dest);   \
    auto res = dest;        \
    res = dest + src;       \
    cpu->CF = (res < dest); \
    cpu->OF = msbset(~(dest ^ src) & (dest ^ res));\
    UPDATE_ZPF(res);        \
    dest = res;             \
})
#define INST_SUB(_dest, src) ({  \
    auto &dest = (_dest);        \
    auto res = dest - src;       \
    cpu->CF = (dest < src);      \
    cpu->OF = msbset((dest ^ src) & (dest ^ res)); \
    UPDATE_ZPF(res);             \
    dest = res;                  \
})
#define INST_MOVZX(dest, src) ({dest = src;})

#define INST_CBW() ({cpu->AX = SIGNED(cpu->AL);})

#define BITWISATRON(_dest, src, op) ({ \
    auto &dest = (_dest);   \
    dest op (src);          \
    cpu->CF = 0;            \
    cpu->OF = 0;            \
    UPDATE_ZPF(dest);      \
})

#define INST_XOR(dest, src) BITWISATRON(dest, src, ^=)
#define INST_AND(dest, src) BITWISATRON(dest, src, &=)
#define INST_OR(dest, src)  BITWISATRON(dest, src, |=)
#define INST_TEST(dest, src) ({\
    auto tmp = (dest);           \
    BITWISATRON(tmp, src, &=); \
})

#define INST_NOT(dest)  ({(dest) = ~(dest);})

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
    MEM_BYTE(cpu->ES*SEGM + cpu->DI) = cpu->AL; \
    cpu->DI += 1;       \
})
#define INST_STOSW() ({ \
    MEM_WORD(cpu->ES*SEGM + cpu->DI) = cpu->AX; \
    cpu->DI += 2;       \
})
#define INST_STOSD() ({   \
    MEM_DWORD(cpu->ES*SEGM + cpu->DI) = cpu->EAX; \
    cpu->DI += 4;         \
})

#define INST_MOVSD() ({ \
    MEM_DWORD(cpu->ES*SEGM + cpu->DI) = MEM_DWORD(cpu->SI); \
    cpu->SI += 4; \
    cpu->DI += 4; \
})

#define INST_CWD() ({ \
    if(msbset(cpu->AX)){ \
        cpu->DX = 0xFFFF; \
    }else{                \
        cpu->DX = 0;      \
    }                     \
})

#define INST_CDQ() ({ \
    if(msbset(cpu->EAX)){ \
        cpu->EDX = 0xFFFFFFFF; \
    }else{                \
        cpu->EDX = 0;     \
    }                     \
})

#define INST_XLAT() ({cpu->AL = MEM_BYTE(cpu->BX + cpu->AL);})

