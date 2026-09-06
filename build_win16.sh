#openwatcom needs to be correctly set up for this to run
#this include is necessary for the github build
INCLUDE=/opt/watcom/h:/opt/watcom/h/win
nasm -f obj win16/terep2re.asm
wcl -3 -ml -k32768 -zastd=c99 -bcl=windows win16/terep2re.obj win16/terep2re.c commdlg.lib
sha256sum win16/terep2re.exe