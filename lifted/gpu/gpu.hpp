//GPU stands for Gambiarra Processing Unit :)
#pragma once

#include <cstdint>
#include <cstdio>

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

#define INST_PUSHF() INST_PUSH(cpu->rawFlags)
#define INST_POPF()  INST_POP(cpu->rawFlags)

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

#define UPDATE_ZPS(val)({ \
    cpu->flagtrio = 0;    \
    cpu->ZF = val == 0;   \
    cpu->SF = msbset(val);\
    /*the builtin is the oposite of the x86 flag*/ \
    cpu->PF = !__builtin_parity(val & 0xff); \
})


void DOS3Call(cpu_ctx*);

#define INST_NOP() ({})

#define INST_ADD(dest, src) ({ \
    auto valL = (dest);        \
    typeof(valL) valR = (src); \
    typeof(valL) res;          \
    res = valL + valR;         \
    cpu->CF = (res < valL);    \
    cpu->OF = msbset((typeof(valL))(~(valL ^ valR) & (valL ^ res)));\
    UPDATE_ZPS(res);           \
    dest = res;                \
})
#define INST_SUB(dest, src) ({ \
    auto valL = (dest);        \
    typeof(valL) valR = (src); \
    typeof(valL) res;          \
    res = valL - valR;         \
    cpu->CF = (valL < valR);   \
    cpu->OF = msbset((typeof(valL))((valL ^ valR) & (valL ^ res)));\
    UPDATE_ZPS(res);           \
    dest = res;                \
})

#define INST_NEG(dest) ({ \
    auto val = (dest);    \
    typeof(val) tmp = 0;  \
    INST_SUB(tmp, val);   \
    dest = tmp;           \
})

#define INST_INC(dest) ({\
    auto tmp = cpu->CF;  \
    INST_ADD(dest, 1);   \
    cpu->CF = tmp;       \
})
#define INST_DEC(dest) ({\
    auto tmp = cpu->CF;  \
    INST_SUB(dest, 1);   \
    cpu->CF = tmp;       \
})

#define INST_SHL(dest, count) ({ \
    dest <<= count;        \
    cpu->rawFlags = 0xbad; \
})

#define INST_SHR(dest, count) ({ \
    dest >>= count;        \
    cpu->rawFlags = 0xbad; \
})
#define INST_SAR(dest, count) ({ \
    auto tmp = SIGNED(dest);    \
    tmp >>= count;              \
    dest = tmp;                 \
    cpu->rawFlags = 0xbad;      \
})


#define CHECK_FLAGS() ({ \
    if(cpu->rawFlags == 0xbad) { \
        printf("next branch needs good flags! line: %d\n", __LINE__);\
        __builtin_trap(); \
    } \
})

#define INST_MOVZX(dest, src) ({dest = src;})

#define INST_CMP(dest, src) ({ \
    auto tmp = (dest);  \
    INST_SUB(tmp, src); \
})

#define INST_CBW() ({cpu->AX = SIGNED(cpu->AL);})

#define BITWISATRON(dest, src, op) ({ \
    dest op (src);          \
    cpu->CF = 0;            \
    cpu->OF = 0;            \
    UPDATE_ZPS(dest);       \
})

#define INST_XOR(dest, src) BITWISATRON(dest, src, ^=)
#define INST_AND(dest, src) BITWISATRON(dest, src, &=)
#define INST_OR(dest, src)  BITWISATRON(dest, src, |=)
#define INST_TEST(dest, src) ({\
    auto tmp = (dest);         \
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
    cpu->DX = msbset(cpu->AX) ? 0xFFFF : 0; \
})

#define INST_CDQ() ({ \
    cpu->EDX = msbset(cpu->EAX) ? 0xFFFFFFFF : 0; \
})

#define INST_XLAT() ({cpu->AL = MEM_BYTE(cpu->BX + cpu->AL);})


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

#define INST_IMUL(...)  inner_imul(cpu,__VA_ARGS__);

static inline void inner_idiv(cpu_ctx *cpu, uint16_t a){
    int32_t num = (int32_t)(((uint32_t)cpu->DX << 16) | cpu->AX);
    int16_t den = SIGNED(a);
    
    cpu->AX = (uint16_t)(num / den);
    cpu->DX = (uint16_t)(num % den);
}

static inline void inner_idiv(cpu_ctx *cpu, uint32_t a){
    int64_t num = (int64_t)(((uint64_t)cpu->EDX << 32) | cpu->EAX);
    int32_t den = SIGNED(a);
    
    cpu->EAX = (uint32_t)(num / den);
    cpu->EDX = (uint32_t)(num % den);
}

#define INST_IDIV(a) inner_idiv(cpu, a);

static inline void inner_mul(cpu_ctx *cpu, uint16_t a) {
    uint32_t res = (uint32_t)cpu->AX * (uint32_t)a;
    cpu->AX = (uint16_t)res;
    cpu->DX = (uint16_t)(res >> 16);
}

static inline void inner_mul(cpu_ctx *cpu, uint32_t a) {
    uint64_t res = (uint64_t)cpu->EAX * (uint64_t)a;
    cpu->EAX = (uint32_t)res;
    cpu->EDX = (uint32_t)(res >> 32);
}

#define INST_MUL(op) inner_mul(cpu, op); 

#define INST_ADC(dest, src) ({ \
    static_assert(sizeof(dest) == 2, "ADC so aceita operando de 16 bits, mermão!"); \
    uint16_t s = (src); \
    dest += s + (cpu->CF ? 1 : 0); \
    cpu->rawFlags = 0xbad; \
})

static inline void inner_div(cpu_ctx *cpu, uint16_t a) {
    uint32_t num = ((uint32_t)cpu->DX << 16) | cpu->AX;
    cpu->AX = (uint16_t)(num / a);
    cpu->DX = (uint16_t)(num % a);
}

static inline void inner_div(cpu_ctx *cpu, uint32_t a) {
    uint64_t num = ((uint64_t)cpu->EDX << 32) | cpu->EAX;
    cpu->EAX = (uint32_t)(num / a);
    cpu->EDX = (uint32_t)(num % a);
}

#define INST_DIV(op) inner_div(cpu, op)



//we dont care about the direction flag, always forward
#define INST_CLD INST_NOP
