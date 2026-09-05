cd reasm32
    nasm -f win32 the_thing.asm
cd ..
wcl386 -bt=nt -l=nt_win win32/terep2re.c shell32.lib user32.lib ole32.lib
#g++ -Og -g -m32 -lSDL3 linux_port/the_thing.cpp reasm32/the_thing.o -o terep2re
