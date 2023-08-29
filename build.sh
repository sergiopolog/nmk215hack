#!/bin/sh
asl patch.s -i . -n -U -x -v -o nmk215-attack.o
p2bin nmk215-attack.o nmk215-attack.bin
rm nmk215-attack.o
