#openwatcom needs to be correctly set up for this to run
nasm -f obj test.asm
wcl -3 -ml -k32768 -zastd=c99 -bcl=windows test.obj main.c