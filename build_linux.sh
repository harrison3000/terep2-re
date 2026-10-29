#!/bin/bash

gcc -Og -g -lSDL3 -lm \
    sdl_port/the_thing.c \
    lifted/maincode.c \
    lifted/othathings.c \
    insulator/insulator.c \
    -o build/terep2re_sdl
