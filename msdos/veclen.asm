
calculate_and_pray:
    enter	8, 0
    ;TODO use registers instead of stack variables!
    push edx
    mov ebx, 0
    mov ecx, 0

    mov eax, [bp + 4]
    imul eax
    add  ebx, eax
    adc  ecx, edx

    mov eax, [bp + 8]
    imul eax
    add  ebx, eax
    adc  ecx, edx

    mov eax, [bp + 12]
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
    leave
    ret 4*3
