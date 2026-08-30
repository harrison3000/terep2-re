
%include "variables.asm"
%include "macros.asm"
%include "maincode32.asm"


DOS3Call:
    MOV word [0xff00], 0xd3ca
    MOV [0xff02], AX
    MOV [0xff04], BX
    MOV [0xff06], CX
    MOV [0xff08], DX

    .mloop:
    pause
    cmp word [0xff00], 0xd3ca
    jz .mloop

    MOV AX, [0xff02]
    MOV BX, [0xff04]
    MOV CX, [0xff06]
    MOV DX, [0xff08]
    CMP word [0xff0a], 2 ; 1 to activate the cf, above 2 to clear it

    ret


global asm_f_init

asm_f_init:
    PUSHAD
    PUSH FS
    PUSH GS
    PUSH DS
    PUSH ES

    MOV AX, _DATA2
    MOV DS, AX

    call f_init

    MOV word [0xff00], 0xbeef

    POP ES
    POP DS
    POP GS
    POP FS
    POPAD