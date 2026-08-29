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

    //segment registers, will be used with a multiplier to emulate segments
    //(defined below, not exactly 16 like in the original real mode) 
    uint16_t DS; //should ALWAYS be zero
    uint16_t CS; //should never be used
    uint16_t ES, FS, GS;

    uintptr_t mem_base;

    std::vector<stackItem> stack;


    //TODO flags! that cant be done with last res
};

//each segment is already 64k, so we only need to increment the segments by 1
//TODO add a 4k buffer zone so we can fault on writes beyond 64k?
#define SEGM 0x10000

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

#define INST_TEST(dest, src) ({ \
    auto tmp = dest; \
    tmp &= src;      \
})
#define INST_CMP(dest, src) ({ \
    auto tmp = dest; \
    tmp -= src;      \
})

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

#define INST_CDQ() ({ \
    if(cpu->EAX & 0x80000000){ \
        cpu->EDX = 0xFFFFFFFF; \
    }else{                \
        cpu->EDX = 0;     \
    }                     \
})

#define INST_XLAT() ({cpu->AL = MEM_BYTE(cpu->BX + cpu->AL);})

#define INST_MUL(op) ({    \
    _Static_assert(sizeof(op) == 2, "We only support 16bit for this instructions"); \
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