#!/bin/sh
asl test-sp.s -i . -n -U -x -v -o test-sp.o
p2bin test-sp.o test-sp.bin
rm test-sp.o
