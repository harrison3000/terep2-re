rm -f build/terep2sx.exe
nasm -f obj msdos/theThing.asm
/opt/watcom/binl64/wlink  @msdos/link.lnk
mv terep2sx.exe build/