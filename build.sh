#openwatcom needs to be correctly set up for this to run
nasm -f obj terep2re.asm
wcl -3 -ml -k32768 -zastd=c99 -bcl=windows terep2re.{obj,c}