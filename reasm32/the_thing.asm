
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
global asm_render
global asm_physics
global asm_keys

asm_f_init:
    airlock_prologue

    ;dont know how much difference does this make, but better safe than sorry
    MOV dword [CSD_DWORD_1000_12a3], 0x7FFF0000
    MOV byte[CSD_BYTE_1000_59c1], 0xf

    call f_init
    MOV word [0xff00], 0xbeef
    push word [0xdb10]
    pop word [0xff50]

    airlock_epilogue
    ret

asm_render:
    airlock_prologue

    call FUN_main_render

    airlock_epilogue
    ret


asm_physics:
    airlock_prologue

    call FUN_timer_5680

    airlock_epilogue
    ret

asm_keys:
    airlock_prologue

    ;TODO get keys from the window
    call FUN_keyboard_56df

    airlock_epilogue
    ret