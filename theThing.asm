bits 16

segment code
    ..start:

    %include "reasm/maincode.asm"

segment data align=16
    incbin "memdumps/data.bin"

    db "SUPER SEPARATOR, DATA MOVED FROM CS BELOW", 0

    %include "reasm/cs_data.asm"

segment stack class=stack
    times 128 dd 'TheStack'

