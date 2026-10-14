export WATCOM=/opt/watcom
export PATH=$WATCOM/binl64:$WATCOM/binl:$PATH
export EDPATH=$WATCOM/eddat
export WIPFC=$WATCOM/wipfc

export INCLUDE=$WATCOM/h:$WATCOM/h/win

nasm -f obj win16/terep2re.asm
wcl -3 -ml -k32768 -zastd=c99 -bcl=windows win16/terep2re.obj win16/terep2re.c commdlg.lib
sha256sum win16/terep2re.exe