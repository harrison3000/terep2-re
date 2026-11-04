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

segment code
    ..start:

    patchPoint 0x46
    ;sets the program block to around 101KB, enough for our code, data and stack with a bit of slack
    mov bx, (36+64+1)*64
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

    patchPoint 0x4e57
    push eax
    padUntil 0x4e5b

    patchPoint 0x4e72
    push eax
    padUntil 0x4e76

    patchPoint 0x4e8d
    push eax
    padUntil 0x4e91

    patchPoint 0x4e91
    call calculate_and_pray

    jumpabs 0x4eb8

    patchPoint 0x5689
    mov ax, data

    ;includes the rest of the file
    incbin "../memdumps/code.bin", ($ - $$)

    %include "veclen.asm"
    %include "decompressor.asm"

segment data align=16
    datac_inc 0, 384, 384
    datac_inc 1440, 96, 480
    datac_inc 6624, 192, 672
    datac_inc 23040, 480, 1152
    datac_inc 53472, 2880, 4032
    datac_inc 58752, 96, 4128
    datac_inc 59808, 288, 4416
    datac_inc 60384, 960, 5376

segment dataRest
    resb 60000

segment stack class=stack align=16
    resb 2048

