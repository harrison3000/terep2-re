#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "immintrin.h"

//Raiz quadrada testeitor tabajara


int32_t theOriginalKinda(int32_t a, int32_t b, int32_t c, double *out){
    double aa = a;
    double bb = b;
    double cc = c;

    double val = __builtin_sqrt(aa*aa + bb*bb + cc*cc);

    out[0] = val / 1024.0;

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
    //TODO find better shifts
    int64_t as = (int64_t)a * a;
    int64_t bs = (int64_t)b * b;
    int64_t cs = (int64_t)c * c;

    as += bs;
    as += cs;

    _Bool biggus = as & (0xfff0L << 48);

    int32_t val = (as >> 32);
    if(!biggus){
        val = (as >> 20);
    }

    int32_t sqr = sqrt_i32(val);

    if(!biggus){
        return sqr;
    }

    return sqr << 6;;
}


int main(){
    uint32_t rs; 
    while(!_rdrand32_step(&rs)){}
    srand48(rs);

    for(int i = 0; i < 1000; i++){        
        for(int s = 0; s < 30; s++){
            uint32_t mask = 0x7fffffff >> s;
            int32_t a = lrand48() & mask;
            int32_t b = lrand48() & mask;
            int32_t c = lrand48() & mask;

            double oo;
            int32_t res = theOriginalKinda(a, b, c, &oo);
            int32_t res2 = theGambiarra(a, b, c);

            if(res != res2){
                printf("%d\t%d\t mask: %08x actual: %.02f\n", res, res2, mask, oo);
            }
        }
    }


    return 0;
}