#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <fcntl.h>
#include <unistd.h>
#include "fcntl.h"

#include "lifted/gpu/gpu.hpp"
#include "lifted/gpu/types.hpp"

void f_init(cpu_ctx *cpu);

int main(){
    auto cpu = new cpu_ctx;
    auto memory = malloc(2 * 1024 * 1024);

    auto f = open("memdumps/data.bin",O_RDONLY);
    int rd = read(f, memory, 64 * 1024);
    printf("read: %d bytes of data", rd);
    close(f);

    cpu->mem_base = (uintptr_t)memory;

    f_init(cpu);


    return 0;
}

void DOS3Call(cpu_ctx *cpu){
    printf("DOS3Call called AX: %x\n", cpu->AX);
    switch(cpu->AH){
        case 0x3d:{
            auto addr = cpu->mem_base + cpu->DX;
            auto fname = (char*)addr;
            auto fd = open(fname, O_RDONLY);
            printf("trying to open: %s, returned: %d\n", fname, fd);
            cpu->CF = fd < 0;
            cpu->AX = fd;
        }
    }
    
}