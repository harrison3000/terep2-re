cd reasm32
    nasm -f win32 -DWIN32 the_thing.asm
cd ..
wcl386 -6 -os -zastd=c99 -bt=nt -l=nt_win reasm32/the_thing.obj win32/terep2re.c shell32.lib user32.lib ole32.lib -fe=terep2re32.exe
