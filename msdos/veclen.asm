
calculate_and_pray:
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

    test  ecx, 0xffffc000
    jnz .sad_path
      
    ;smol number, less pre-shift, less iterations, no post-shift
    shrd ebx, ecx, 20
    mov ecx, 1 << 24
    
    .let_it_rip:
    

    ;all the numbers are squared, lets to the square root now

    ;based on: https://github.com/chmike/fpsqrt/blob/master/fpsqrt.c
    ;also available at: https://github.com/torvalds/linux/blob/master/lib/math/int_sqrt.c
    ;the original code seems to be older than me!

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

    ret

    .sad_path:
    test  ecx, 0xfff00000
    jnz .bigus

    ;kinda big numbers
    shrd ebx, ecx, 20
    mov ecx, 1 << 30
    jmp .let_it_rip

    .bigus:
    ;really big numbers, rarer case, uses only the upper dword and left shift the result
    mov ebx, ecx ;equivalent of a right shift by 32 here
    mov ecx, 1 << 30
    call .let_it_rip
    shl eax, 6
    ret
