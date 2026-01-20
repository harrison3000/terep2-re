bits 16

%macro patchPoint 1
    incbin "memdumps/code.bin", ($ - $$), %1 - ($ - $$)
%endmacro

%macro padUntil 1
    times (%1 - ($ - $$)) nop
%endmacro

segment code
    ..start:

    patchPoint 0x46
    mov bx, 0x3000 ;not the best way, but good enough

    patchPoint 0x52
    mov ax, data

    patchPoint 0x236
    mov word [CS:trampolineADest], 0x48d0
    mov word [CS:trampolineBDest], 0x500b

    padUntil 0x252

    patchPoint 0x5689
    mov ax, data

    patchPoint 0x56ba
    call trampolineA

    patchPoint 0x56c8
    call trampolineB

    patchPoint 0x590d
    push ecx
    mov ecx, 28
    eita:
    in al, dx
    loop eita

    pop ecx
    dec dx
    pop ax
    ret

    ;includes the rest of the file
    incbin "memdumps/code.bin", ($ - $$)

    trampolineADest:
        dw 0x5430
    trampolineBDest:
        dw 0x54ec

    trampolineA:
        call [CS:trampolineADest]
        ret

    trampolineB:
        call [CS:trampolineBDest]
        ret

segment data
    incbin "memdumps/data.bin"

segment stack class=stack
    times 128 dd 'TheStack'


;other things
;BYTE_ARRAY_1000_571e 128 bytes, related to keyboard interrupt, stores keys

;interrupts
;func @ 0x5430 seems to be related to setting up interrupts
;0x5680 is the timer interrupt handler I think
;0x553f  irq 00 div by zero
;0x56df  irq 09 keyboard
;0x579e  irq f1 