cd reasm32
    nasm -f elf32 the_thing.asm 2> erros.txt
cd ..
g++ -Og -g -m32 -lSDL3 linux_port/the_thing.cpp reasm32/the_thing.o -o terep2re
