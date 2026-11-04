
%macro datac_inc 3
    incbin "../memdumps/data.bin", %1, %2
%endmacro

%macro data_copy 3
    mov cx, %2
    mov si, %3
    mov di, %1 + %2
    rep movsb
%endmacro

%macro zerod 2
    cld
    mov cx, %2
    mov di, %1
    mov ax, 0
    rep stosb
%endmacro



decompressData:
    push di
    push si
    push cx
    push es

    push ds
    pop  es

    std
    data_copy 60384, 960, 5376
    data_copy 59808, 288, 4416
    data_copy 58752, 96, 4128
    data_copy 53472, 2880, 4032
    data_copy 23040, 480, 1152
    data_copy 6624, 192, 672
    data_copy 1440, 96, 480
    ;data_copy 0, 384, 384
    cld

    zerod 384, 1056
    zerod 1536, 5088
    zerod 6816, 16224
    zerod 23520, 29952
    zerod 56352, 2400
    zerod 58848, 960
    zerod 60096, 288
    zerod 61344, 880

    pop es
    pop cx
    pop si
    pop di


    ret