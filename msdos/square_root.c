#include "stdio.h"
#include "stdlib.h"
#include "stdint.h"
#include "immintrin.h"
#include <stdint.h>





uint32_t theOriginalKinda(uint32_t a, uint32_t b, uint32_t c){
    double aa = a;
    double bb = b;
    double cc = c;

    float val = __builtin_sqrt(aa*aa + bb*bb + cc*cc);
    uint32_t r = val;

    r >>= 10;

    return r;
}



int main(){
    uint32_t rs; 
    _rdrand32_step(&rs);
    srand48(rs);

    for(int i =0; i< 999; i++){
        uint32_t a = lrand48();
        uint32_t b = lrand48();
        uint32_t c = lrand48();

        uint32_t res = theOriginalKinda(a, b, c);

        printf("%d\n", res);


    }


    return 0;
}