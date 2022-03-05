#!/usr/bin/env bash

## compile with fpc + flags
fpc -O3 -CpCOREAVX2 -OpCOREAVX2 -CfAVX2 -Xs pasfetch.pas


## Remove object & discriptive files
find . -name "*.o" -type f -delete
find . -name "*.ppu" -type f -delete
