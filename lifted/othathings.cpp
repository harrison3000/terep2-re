#include "gpu/types.hpp"
#include "public_declrs.hpp"
#include "variables.hpp"
#include <cstdint>
#include <cstring>


const uint8_t initialdata[] = {
    #embed "../memdumps/data_compact.bin"
};


cpu_ctx *initCPU(){
    auto cpu = new cpu_ctx;

    auto memory = new uint8_t[2 * 1024 * 1024];
    cpu->mem_base = (uintptr_t)memory;
    cpu->segments[0] = cpu->mem_base;

    int oi = 0;
    for(int i =0; i < sizeof(initialdata); i++){
        uint8_t data = initialdata[i];
        if(data != 0){
            memory[oi] = data;
            oi++;
            continue;
        }
        i++;
        uint8_t qtd = initialdata[i];
        for(int j = 0; j<qtd; j++){
            memory[oi] = 0;
            oi++;
        }
    }

    strcpy(&((char*)memory)[0xf700], "GAMBIARRA FOREVER!");

    cpu->vars = new otherVars;


    for(int i = 0; i < 128; i++){
        cpu->vars->CSD_DAT_keys_571e[i] = 0xff;
    }
    uint8_t something[] = {0,1,2,8,9,0xa, 0x10, 0x11, 0x12};
    for(int i = 0; i < sizeof(something); i++){
        cpu->vars->CSD_DAT_unk_592c[i] = something[i];
    }

    return cpu;
}

void finalizeCpu(cpu_ctx *cpu){
    delete cpu->vars;
    auto mem = (uint8_t *)cpu->mem_base;
    delete mem;
    delete cpu;
}

//TODO deleter