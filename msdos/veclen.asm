ye_olde_calc:
    FINIT
    FILD       dword [0xe9ec]
    FMUL       ST0
    FILD       dword [0xe9f0]
    FMUL       ST0
    FILD       dword [0xe9f4]
    FMUL       ST0
    FADDP
    FADDP
    FSQRT
    FISTP      dword [0xe9e8]
    MOV        EAX,[0xe9e8]
    SAR        EAX,0xa

    ret


calculate_and_pray:
    enter	8, 0
    ;TODO use registers instead of stack variables!
    push edx
    mov dword [bp - 8], 0
    mov dword [bp - 4], 0

    mov eax, dword [0xe9ec]
    imul eax
    add dword [bp - 8], eax
    adc dword [bp - 4], edx

    mov eax, dword [0xe9f0]
    imul eax
    add dword [bp - 8], eax
    adc dword [bp - 4], edx

    mov eax, dword [0xe9f4]
    imul eax
    add  eax, dword [bp - 8]
    adc  edx, dword [bp - 4]

    shrd eax, edx, 24

    ;all the numbers are squared, lets to the square root now
    push ecx

    ;based on: https://github.com/chmike/fpsqrt/blob/master/fpsqrt.c
    ;Original C code
    ;   MIT licensed
    ;   Copyright (c) 2019 Christophe Meessen

    mov ecx, 1 << 30
    mov ebx, 0
    
    .daloop:
        lea edx, [ebx + ecx];
        shr ebx, 1
        cmp eax, edx
        jb .nope
            sub eax, edx
            add ebx, ecx
        .nope:
        shr ecx, 2;
    jecxz .getout
    jmp .daloop
    .getout:

    mov eax, ebx

    shl eax, 2

    pop ecx
    pop edx
    leave
    ret
