#include "variables.hpp"


const uint8_t initialdata[] = {
    #embed "../memdumps/data.bin"
};

void otherVars::init(){
    for(int i = 0; i < 128; i++){
        CSD_DAT_keys_571e[i] = 0xff;
    }
    
}