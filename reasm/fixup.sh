sed /^CODE_1/q terep2re.exe.txt > /tmp/temp1.txt
cut -b 29- /tmp/temp1.txt > /tmp/cutbom.asm
sed -E -f fixup.sed /tmp/cutbom.asm > maincode.asm