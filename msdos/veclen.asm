
calculate_and_pray:
    push edx

    mov eax, dword [0xe9ec]
    imul eax
    mov  ebx, eax
    mov  ecx, edx

    mov eax, dword [0xe9f0]
    imul eax
    add  ebx, eax
    adc  ecx, edx

    mov eax, dword [0xe9f4]
    imul eax
    add  ebx, eax
    adc  ecx, edx

    shrd ebx, ecx, 24

    ;all the numbers are squared, lets to the square root now

    ;based on: https://github.com/chmike/fpsqrt/blob/master/fpsqrt.c
    ;Original C code
    ;   MIT licensed
    ;   Copyright (c) 2019 Christophe Meessen

    mov ecx, 1 << 30
    mov eax, 0
    
    .daloop:
        lea edx, [eax + ecx];
        shr eax, 1
        cmp ebx, edx
        jb .nope
            sub ebx, edx
            add eax, ecx
        .nope:
        shr ecx, 2;
    jnz .daloop

    shl eax, 2

    pop edx
    ret
