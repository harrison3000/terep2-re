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
    mov bx, 0x3000 ;not the best way, but good enough FIXME put the actual value here

    patchPoint 0x52
    mov ax, data

    patchPoint 0x57
    jmp afterThings

    patchPoint 0xdc
    afterThings:

    patchPoint 0x236
    jmp afterThings2

    padUntil 0x252
    afterThings2:

    patchPoint 0x48d0
    somefuncc_a:

    patchPoint 0x500b
    somefuncc_b:

    patchPoint 0x5689
    mov ax, data

    patchPoint 0x56ba
    call somefuncc_a

    patchPoint 0x56c8
    call somefuncc_b

    patchPoint 0x590d
    push ecx
    mov ecx, 28
    ;originally unrolled, but ghidra didnt like it, and I dont like it either
    eita:
    in al, dx
    loop eita

    pop ecx
    dec dx
    pop ax
    ret

    ;includes the rest of the file
    incbin "memdumps/code.bin", ($ - $$)

segment data
    incbin "memdumps/data.bin"

segment stack class=stack
    times 128 dd 'TheStack'

