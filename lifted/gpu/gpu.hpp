//GPU stands for Gambiarra Processing Unit :)
#pragma once

#include <cstdint>
#include <vector>
#include <bit>

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

    //segment registers, will be used with a multiplier (1024, not 16 like in the original real mode) to fake segments
    uint16_t DS; //should ALWAYS be zero
    uint16_t CS; //should never be used
    uint16_t ES, FS, GS;

    uintptr_t mem_base;

    std::vector<stackItem> stack;


    //TODO flags! that cant be done with last res
};

#define SEGM 1024

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

inline int8_t SIGNED(uint8_t v) { return v; }
inline int16_t SIGNED(uint16_t v) { return v; }
inline int32_t SIGNED(uint32_t v) { return v; } 

//the builtin is the oposite of the x86 flag
#define PARITY(val) (!__builtin_parity(val))

//TODO implement
#define DOS3Call(cpu) ({})

#define INST_NOP() ({})

#define INST_ADD(dest, src) ({dest += src;})
#define INST_SUB(dest, src) ({dest -= src;})
#define INST_NEG(dest) ({ \
    auto ds = SIGNED(dest);\
    dest = ds; \
})
#define INST_SHL(dest, src) ({dest <<= src;})
#define INST_SHR(dest, src) ({dest >>= src;})
#define INST_SAR(dest, src) ({ \
    auto ds = SIGNED(dest);\
    ds >>= src; \
    dest = ds; \
})
#define INST_ROL(dest, src) ({dest = std::rotl(dest, src);})
#define INST_ROR(dest, src) ({dest = std::rotr(dest, src);})

#define INST_INC(dest) ({dest += 1;})
#define INST_DEC(dest) ({dest += 1;})

#define INST_MOVZX(dest, src) ({dest = src;})

#define INST_TEST(dest, src) ({(typeof(dest))(dest & src);})

#define INST_XOR(dest, src) ({dest ^= src;})
#define INST_AND(dest, src) ({dest &= src;})
#define INST_OR(dest, src)  ({dest |= src;})

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
    if(cpu->AX & 0x8000){ \
        cpu->DX = 0xFFFF; \
    }else{                \
        cpu->DX = 0;      \
    }                     \
})

#define INST_XLAT() ({cpu->AL = MEM_BYTE(cpu->BX + cpu->AL);})


