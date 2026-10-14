#!/bin/bash


g++ -Og -g -lSDL3 \
    linux_port/the_thing.cpp \
    lifted/maincode.cpp \
    lifted/othathings.cpp \
    insulator/insulator.cpp \
    -o build/terep2re_linux
