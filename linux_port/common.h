#pragma once

#define MEM_VAL(addr, type) ({    \
    uintptr_t finalAddr = (uintptr_t)base_mem + (addr); \
    (type *)finalAddr; \
})[0]


#define MEM_BYTE(addr)  MEM_VAL(addr, uint8_t)
#define MEM_WORD(addr)  MEM_VAL(addr, uint16_t)
#define MEM_DWORD(addr) MEM_VAL(addr, uint32_t)
