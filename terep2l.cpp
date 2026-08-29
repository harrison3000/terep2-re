#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <fcntl.h>
#include <string>
#include <unistd.h>
#include "fcntl.h"

#include "lifted/gpu/gpu.hpp"
#include "lifted/gpu/types.hpp"

void f_init(cpu_ctx *cpu);

std::string basedir;

int main(int argc, char **argv){
    auto cpu = new cpu_ctx;
    auto memory = malloc(2 * 1024 * 1024);

    auto f = open("memdumps/data.bin",O_RDONLY);
    int rd = read(f, memory, 64 * 1024);
    printf("read: %d bytes of data\n", rd);
    close(f);

    cpu->mem_base = (uintptr_t)memory;

    if(argc > 1){
        basedir = argv[1];
    }

    f_init(cpu);


    return 0;
}

void DOS3Call(cpu_ctx *cpu){
    printf("DOS3Call called AX: %x\n", cpu->AX);
    switch(cpu->AH){
        case 0x3d:{
            auto addr = cpu->mem_base + cpu->DX;
            auto fname = (char*)addr;
            auto fullpath = basedir + fname;

            auto fd = open(fullpath.c_str(), O_RDONLY);
            printf("trying to open: %s, returned: %d\n", fname, fd);
            cpu->CF = fd < 0;
            cpu->AX = fd;
            return;
        }
        case 0x48:{
            static int current_seg = 0;
            current_seg += 68; // a bit more for safety
            printf("game asked for %d paragraphs (%d bytes), we gave it a full 64k block anyway\n", cpu->BX, cpu->BX * 16);
            cpu->AX = current_seg;
            cpu->CF=0;
            return;
        }
    }

    printf("Handler not implemented yet \n");
    exit(1);
}