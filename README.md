# Pasfetch

My personal build of [Drunken Alcoholic](https://gitlab.com/DrunkenAlcoholic)'s [Pasfetch](https://gitlab.com/DrunkenAlcoholic/pasfetch/), a simple fetch program written in Pascal.


## Screenshot
![alt text](img/souldj673-pasfetch-scrot.png "Pasfetch")

## Installation
You can compile Pasfetch with the free an open source "Free Pascal Compiler" just search your distro's packages for "fpc" and install, then to compile you do the following:

### Compile
use fpc to compile with these optimized option
```bash
$ fpc -O3 -CpCOREAVX2 -OpCOREAVX2 -CfAVX2 -Xs pasfetch.pas
```
or run the included shell script to compile and cleanup
```bash
$ ./cleanup.sh
```
if you get an error on "ld" not found, install "binutils" package for your distribution

### Install
 Copy the compiled binary to your path folder e.g "/$HOME/.local/bin"
 
 then make it executable
 ```bash
 $ chmod +x pasfetch
 ```


## Usage
Either call the program by using pasfetch in a shell or add to your .bashrc, .kshrc, .zshrc, etc.

```bash
$ pasfetch
```


