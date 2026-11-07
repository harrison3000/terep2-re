
%macro datac_inc 3
    incbin "../memdumps/data.bin", %1, %2
%endmacro

%macro data_copy 3
    mov cx, %2 / 4
    mov si, %3 - 4
    mov di, %1 + %2 - 4
    rep movsd
%endmacro

%macro zerod 2
    mov cx, %2 / 4
    mov di, %1
    rep stosd
%endmacro



decompressData:
    push di
    push si
    push cx
    push es

    push ds
    pop  es

    std

    data_copy 60760, 544, 4224
    data_copy 60440, 256, 3680
    data_copy 59944, 112, 3424
    data_copy 59872, 8, 3312
    data_copy 58752, 16, 3304
    data_copy 56248, 16, 3288
    data_copy 53512, 2576, 3272
    data_copy 23120, 368, 696
    data_copy 6656, 72, 328
    data_copy 1496, 32, 256
    data_copy 280, 16, 224
    ;data_copy 0, 208, 208

    cld
    xor eax, eax

    zerod 208, 72
    zerod 296, 1200
    zerod 1528, 5128
    zerod 6728, 16392
    zerod 23488, 30024
    zerod 56088, 160
    zerod 56264, 2488
    zerod 58768, 1104
    zerod 59880, 64
    zerod 60056, 384
    zerod 60696, 64
    zerod 61304, 920

    pop es
    pop cx
    pop si
    pop di


    ret