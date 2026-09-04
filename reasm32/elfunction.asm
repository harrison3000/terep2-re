


F_WRAP_STOSB:
    mk_addr_seg EBP, ptr_seg_EeS, [DI]
    mov byte [EBP], al
    add_noflags DI, 1
    ret

F_WRAP_STOSW:
    mk_addr_seg EBP, ptr_seg_EeS, [DI]
    mov word [EBP], ax
    add_noflags DI, 2
    ret



F_WRAP_LODSB:
    mk_addr     EBP, [SI]
    mov al, byte [EBP]
    add_noflags SI, 1
    ret

F_WRAP_LODSW:
    mk_addr     EBP, [SI]
    mov ax, word [EBP]
    add_noflags SI, 2
    ret

F_WRAP_LODSD:
    mk_addr     EBP, [SI]
    mov eax, dword [EBP]
    add_noflags SI, 4
    ret

F_WRAP_MOVSD:
    ;can be optimized, but not now
    mk_addr     EBP, [SI]
    push dword [EBP]
    mk_addr_seg EBP, ptr_seg_EeS, [DI]
    pop dword [EBP]
    add_noflags SI, 4
    add_noflags DI, 4
    ret

F_WRAP_XLAT:
    PUSH EBX
    mk_addr     EBP, [BX]
    MOVZX EBX, AL
    add_noflags EBX, EBP
    MOV AL, byte [EBX]
    POP EBX
    ret


F_WRAP_REP_STOSW:
    JCXZ .this_is_the_end
    mk_addr_seg EBP, ptr_seg_EeS, [DI]
    .looopl:
        mov word [EBP], ax
        add_noflags EBP, 2
        add_noflags DI, 2

    a16 LOOP .looopl
    .this_is_the_end:
    ret