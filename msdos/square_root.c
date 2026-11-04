#include "stdio.h"
#include "stdlib.h"
#include "stdint.h"
#include "immintrin.h"
#include <stdint.h>

//Raiz quadrada testeitor tabajara


int32_t theOriginalKinda(int32_t a, int32_t b, int32_t c){
    double aa = a;
    double bb = b;
    double cc = c;

    float val = __builtin_sqrt(aa*aa + bb*bb + cc*cc);
    int32_t r = val;

    r >>= 10;

    return r;
}

//source: https://github.com/chmike/fpsqrt/blob/master/fpsqrt.c
//MIT licensed
//Copyright (c) 2019 Christophe Meessen
int32_t sqrt_i32(int32_t v) {
    uint32_t b = 1<<30, q = 0, r = v;
    while (b > r)
        b >>= 2;
    while( b > 0 ) {
        uint32_t t = q + b;
        q >>= 1;
        if( r >= t ) {
            r -= t;
            q += b;
        }
        b >>= 2;
    }
    return q;
}


int32_t theGambiarra(int32_t a, int32_t b, int32_t c){

    int64_t as = (int64_t)a * a;
    int64_t bs = (int64_t)b * b;
    int64_t cs = (int64_t)c * c;

    as += bs;
    as += cs;

    int64_t u = as >> 22;
    int32_t uu = u;

    int32_t sqr = sqrt_i32(uu);

    return  sqr << 1;
}


int main(){
    uint32_t rs; 
    _rdrand32_step(&rs);
    srand48(rs);

    for(int i = 0x00100000; i< 0x00500000; i++){
        int32_t a = (1 << 26) + i*4;
        int32_t b = (1 << 26) + 77;
        int32_t c = (1 << 26) + i/2;

        int32_t res = theOriginalKinda(a, b, c);
        int32_t res2 = theGambiarra(a, b, c);

        printf("%d\t%d\n", res, res2);


    }


    return 0;
}