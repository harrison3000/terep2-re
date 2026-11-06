
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

    test  ecx, 0xfff00000
    jnz .bigus
      
    ;smol number, less pre-shift, no post-shift
    shrd ebx, ecx, 20
    push word 0
    
    .let_it_rip:
    

    ;all the numbers are squared, lets to the square root now

    ;based on: https://github.com/chmike/fpsqrt/blob/master/fpsqrt.c
    ;Original C code
    ;   MIT licensed
    ;   Copyright (c) 2019 Christophe Meessen

    mov ecx, 1 << 30
    xor eax, eax
    
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

    pop cx    
    shl eax, cl

    pop edx
    ret

    .bigus:
    ;big number, rarer case, uses only the upper dword and right shift later
    mov ebx, ecx ;equivalent of a right shift by 32 here
    push word 6
    jmp .let_it_rip
