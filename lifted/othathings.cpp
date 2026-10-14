#include "variables.hpp"


const uint8_t initialdata[] = {
    #embed "../memdumps/data.bin"
};

void otherVars::init(){
    for(int i = 0; i < 128; i++){
        CSD_DAT_keys_571e[i] = 0xff;
    }
    uint8_t something[] = {0,1,2,8,9,0xa, 0x10, 0x11, 0x12};
    for(int i = 0; i < sizeof(something); i++){
        CSD_DAT_unk_592c[i] = something[i];
    }
}