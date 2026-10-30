#!/bin/bash


gcc -Og -g --std=gnu23 \
    verifyer/main.c \
    lifted/maincode.c \
    lifted/othathings.c \
    insulator/insulator.c \
    -lm \
    -o build/terep2_verifyer