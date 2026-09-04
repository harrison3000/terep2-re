
%include "macros.asm"
%include "../common/macros.asm"

%define _DATA2 0


section .data
base_mem:

incbin "../memdumps/data.bin"

%include "../common/newvars_defs.asm"

ptr_seg_DeS: dd 0
ptr_seg_EeS: dd 0
ptr_seg_FeS: dd 0
ptr_seg_GeS: dd 0

align 8
all_segments:
    times 256 dd 0


data_callregs:
    times 8 dd 0

global data_callregs
global all_segments
global base_mem


section .text

global asm_f_init
global asm_render
global asm_physics
global asm_keys

%include "maincode32.asm"
%include "elfunction.asm"


DOS3Call:
    ;FIXME refactor to use vars
    MOV word [data_callregs], 0xd3ca
    MOV [data_callregs + 2], AX
    MOV [data_callregs + 4], BX
    MOV [data_callregs + 6], CX
    MOV [data_callregs + 8], DX

    .mloop:
    pause
    cmp word [data_callregs], 0xd3ca
    jz .mloop

    MOV AX, [data_callregs + 2]
    MOV BX, [data_callregs + 4]
    MOV CX, [data_callregs + 6]
    MOV DX, [data_callregs + 8]
    CMP word [data_callregs + 10], 2 ; 1 to activate the cf, above 2 to clear it

    ret


asm_f_init:
    airlock_prologue

    mov dword [all_segments], base_mem
    mov dword [ptr_seg_DeS], base_mem

    call f_init

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