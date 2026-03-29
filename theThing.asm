bits 16

segment code
    ..start:

    %include "reasm/maincode.asm"

segment data align=16
    incbin "memdumps/data.bin"

segment stack class=stack
    times 128 dd 'TheStack'

