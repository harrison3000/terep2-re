
%include "macros.asm"
%include "../common/macros.asm"

%define _DATA2 0


section .data
_base_mem:
base_mem:

incbin "../memdumps/data.bin"

%include "../common/newvars_defs.asm"

nova_linha:
    db "GAMBIARRA FOREVER 32!", 0

ptr_seg_DeS: dd 0
ptr_seg_EeS: dd 0
ptr_seg_FeS: dd 0
ptr_seg_GeS: dd 0

align 8
_all_segments:
all_segments:
    times 256 dd 0


_call_portal:
data_callregs:
call_portal:
    .msg: dw 0
    .axr: dw 0
    .bxr: dw 0
    .cxr: dw 0
    .dxr: dw 0
    .cfs: dw 0

;TODO guard value

%ifdef WIN32
    global _call_portal
    global _all_segments
    global _base_mem
%else
    global data_callregs
    global all_segments
    global base_mem
%endif

section .text

%ifdef WIN32
    global asm_f_init_
    global asm_render_
    global asm_physics_
    global asm_keys_
%else
    global asm_f_init
    global asm_render
    global asm_physics
    global asm_keys
%endif

%include "maincode32.asm"
%include "elfunction.asm"


DOS3Call:
    MOV [call_portal.axr], AX
    MOV [call_portal.bxr], BX
    MOV [call_portal.cxr], CX
    MOV [call_portal.dxr], DX

    ;this need to be writen last
    ;there is actually a small but non-zero chance of the function in the C code getting called in-between the MOVs otherwise
    MOV word [call_portal.msg], 0xd3ca

    .mloop:
      ;busy wait until the C side does its thing
      pause
      cmp word [call_portal.msg], 0xd3ca
    jz .mloop

    MOV AX, [call_portal.axr]
    MOV BX, [call_portal.bxr]
    MOV CX, [call_portal.cxr]
    MOV DX, [call_portal.dxr]
    CMP word [call_portal.cfs], 2 ; 1 to activate the cf, above 2 to clear it

    ret


asm_f_init:
asm_f_init_:
    airlock_prologue

    mov dword [all_segments], base_mem
    mov dword [ptr_seg_DeS], base_mem

    call f_init

    MOV word [call_portal.axr],  AX
    MOV word [call_portal.msg], 0xbeef

    airlock_epilogue
    ret

asm_render:
asm_render_:
    airlock_prologue

    call FUN_main_render

    airlock_epilogue
    ret


asm_physics:
asm_physics_:
    airlock_prologue

    call FUN_timer_5680

    airlock_epilogue
    ret

asm_keys:
asm_keys_:
    airlock_prologue

    ;TODO get keys from the window
    call FUN_keyboard_56df

    airlock_epilogue
    ret