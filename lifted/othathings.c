#include "gpu/types.h"
#include "public_declrs.h"
#include "variables.h"
#include <stdint.h>
#include <stdlib.h>
#include <string.h>


const uint8_t initialdata[] = {
    #embed "../memdumps/data_compact.bin"
};


cpu_ctx *initCPU(){
    auto cpu = (cpu_ctx*)calloc(1,sizeof(cpu_ctx));

    auto memory = (uint8_t*)calloc(1,2 * 1024 * 1024);
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

    cpu->vars = (otherVars*)calloc(1,sizeof(otherVars));

    cpu->vars->CSD_DWORD_1000_12a3 = 0x7FFF0000;
    cpu->vars->CSD_BYTE_1000_59c1 = 0xf;

    for(int i = 0; i < 128; i++){
        cpu->vars->CSD_DAT_keys_571e[i] = 0xff;
    }
    uint8_t something[] = {0,1,2,8,9,0xa, 0x10, 0x11, 0x12};
    for(int i = 0; i < sizeof(something); i++){
        cpu->vars->CSD_DAT_unk_592c[i] = something[i];
    }

    cpu->vp_w = 320;
    cpu->vp_h = 200;

    cpu->framebuffer = malloc(2048*2048);

    return cpu;
}

void finalizeCpu(cpu_ctx *cpu){
    free(cpu->vars);
    auto mem = (uint8_t *)cpu->mem_base;
    free(mem);
    free(cpu);
}