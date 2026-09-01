#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <fcntl.h>
#include <string>
#include <unistd.h>
#include "fcntl.h"

#include "lifted/gpu/types.hpp"

void f_init(cpu_ctx *cpu);

std::string basedir;

const uint8_t initData[] = {
    #embed "memdumps/data.bin"
};

int main(int argc, char **argv){
    auto cpu = new cpu_ctx;
    auto memory = malloc(2 * 1024 * 1024);

    memcpy(memory, initData, sizeof(initData));

    cpu->mem_base = (uintptr_t)memory;

    if(argc > 1){
        basedir = argv[1];
    }

    f_init(cpu);


    return 0;
}

void DOS3Call(cpu_ctx *cpu){
    switch(cpu->AH){
        case 0x3d:{
            //file open
            auto addr = cpu->mem_base + cpu->DX;
            auto fname = (char*)addr;
            auto fullpath = basedir + fname;

            auto fd = open(fullpath.c_str(), O_RDONLY);
            printf("trying to open: %s, returned: %d\n", fname, fd);
            cpu->CF = fd < 0;
            cpu->AX = fd;
            return;
        }
        case 0x3f:{
            auto fd = cpu->BX;
            if(cpu->DS != 0){
                printf("Something wrong isnt right\n");
                exit(2);
            }
            auto addr = cpu->mem_base + cpu->DX;
            auto r = read(fd, (void *)addr, cpu->CX);
            cpu->CF = r < 0;
            cpu->AX = r;
            printf("Read %ld bytes from handle: %d\n", r, fd);
            return;
        }
        case 0x42:{
            int off = cpu->CX;
            off <<= 16;
            off += cpu->DX;

            auto offset = lseek(cpu->BX, off, cpu->AL);
            cpu->CF = offset < 0;
            cpu->DX = offset >> 16;
            cpu->AX = offset;
            return;
        }
        case 0x3e:{
            auto ok = close(cpu->BX);
            cpu->CF = ok != 0;
            return;
        }
        case 0x48:{
            //memory alocation
            static int current_seg = 0;
            current_seg += 68; // a bit more for safety
            printf("game asked for %d paragraphs (%d bytes), we gave it a full 64k block anyway\n", cpu->BX, cpu->BX * 16);
            cpu->AX = current_seg;
            cpu->CF=0;
            return;
        }
    }

    printf("Handler not implemented yet, AX: %x\n", cpu->AX);
    exit(1);
}