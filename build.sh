#openwatcom needs to be correctly set up for this to run
#this include is necessary for the github build
INCLUDE=/opt/watcom/h:/opt/watcom/h/win
nasm -f obj terep2re.asm
wcl -3 -ml -k32768 -zastd=c99 -bcl=windows terep2re.obj terep2re.c