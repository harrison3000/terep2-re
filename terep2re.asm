bits 16

segment _CODE2 class=CODE align=16

global initgame_

initgame_:
    mov ax,0x2345
    retf


segment _DATA2 class=DATA align=16
    incbin "memdumps/data.bin"