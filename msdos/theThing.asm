bits 16

%macro patchPoint 1
    incbin "../memdumps/code.bin", ($ - $$), %1 - ($ - $$)
%endmacro

%macro padUntil 1
    times (%1 - ($ - $$)) nop
%endmacro

%macro jumpabs 1
    db 0xe9
    dw (%1 - ($ - $$) - 2)
%endmacro

STACK_SIZE  equ 2048


segment code
    ..start:

    patchPoint 0x46
    ;calculates the size of the program blocks and sets it
    ;this assumes the code is always first and the stack always last
    mov bx, stack
    sub bx, code
    add bx, STACK_SIZE/16 + 32  
    mov ax, 0x4a00
    int 0x21

    mov ax, data
    mov ds, ax

    call decompressData    

    ;jump over the unecessary (an potentially harmful) XMS things
    ;this is the only reason the game "requires" XMS... well, not anymore
    jumpabs 0xdc

    ;we used to jump over a runtime code patching here
    ;but we dont care about that in this branch, we can keep it as is
    ;we will keep things as pristine as possible

    patchPoint 0x25d
    ;squeeze a hlt here so we can run on fast systems without the camera bug
    hlt

    ;we will patch the function  4e0a now

    patchPoint 0x4e91
    call calculate_and_pray

    jumpabs 0x4eb8

    patchPoint 0x5689
    mov ax, data

    ;includes the rest of the file
    ;TODO we can probably shave off a few bytes by overwriting the old XMS functions
    incbin "../memdumps/code.bin", ($ - $$)

    %include "veclen.asm"
    %include "decompressor.asm"

segment data align=16
    datac_inc 0, 208, 208
    datac_inc 280, 16, 224
    datac_inc 1496, 32, 256
    datac_inc 6656, 72, 328
    datac_inc 23120, 368, 696
    datac_inc 53512, 2576, 3272
    datac_inc 56248, 16, 3288
    datac_inc 58752, 16, 3304
    datac_inc 59872, 8, 3312
    datac_inc 59944, 112, 3424
    datac_inc 60440, 256, 3680
    datac_inc 60760, 544, 4224

segment dataRest
    resb 60000

segment stack class=stack align=16
    resb STACK_SIZE

