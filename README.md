# Pasfetch

A simple fetch program writen in pascal, a work in progress but initial upload to github.


## Screenshot
![alt text](img/Pasfetch.Screenshot.png "Pasfetch")

## Installation
You can compile Pasfetch with the free an open source "Free Pascal Compiler" just search your distro's packages for "fpc" and install, then to compile you do the following

### Compile
use fpc to compile with these optimized option
```pascal
fpc -O3 -CpCOREAVX2 -OpCOREAVX2 -CfAVX2 -Xs pasfetch.pas
```
or run the included bash script to compile and cleanup
```bash
./cleanup.sh
```

### Install
 Copy the compiled binary to your path folder e.g /$HOME/bin 


## Usage
either call the program by using pasfetch in a shell or add to your .bashrc 




