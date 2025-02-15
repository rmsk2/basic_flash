# basic_flash

This is a small proof of concept project that shows how to load a SuperBASIC program from onboard flash or a flash cart on the Foenix F256 modern retro
computers. The program simply prints the whole character set together with the character code of each character to the screen. The BASIC program can be found
in the file `allchars.bas` and alternatively can be loaded in the usual way. There is also a pure text version `allchars.src` which allows you to modify the
source code via a [text editor](https://github.com/rmsk2/moreorless).

## Bulding the software

You will need 64tass, a Python3 interpreter and GNU Make to build the software. Simply use `make` to create a flash cartridge image called `cartridge.bin` or
individual 8K flash blocks called `basic_01.bin` and `basic_02.bin`. The 8K blocks can be written to onbaord flash via FoenixMgr and the cartridge image can
be written to a flash cartridge via [fcart](https://github.com/rmsk2/cartflash). Both versions do not depend on the location in flash memory. I.e. as long as
you use consecutive flash blocks these binaries can be stored anywhere in flash memory. Executing `make clean` removes all files which are created during the 
build process.

## Running the software

If you have stored the program in flash you can use `/allchars` at the BASIC prompt or simply `allchars` in DOS. Doing this will restart BASIC. After that
type `xgo` to start the program.

## How does this work?

The first 8K block contains a loader program written in assembly which simply copies the data in the second and optionally additional flash blocks to RAM 
block 20 (which is at 24 bit address $28000) and following. Data which is stored at this address can be loaded via `xload` or loaded and started via `xgo`
by SuperBASIC. If you want to copy more than one flash block, because your BASIC program is larger than 8K, then you can modify the file `flashloader.asm`:

- You have to uncomment one or more of the lines that begin with `BLOCK2`, `BLOCK3` or `BLOCK4`
- You have to change the constant `NUM_8K_BLOCKS` to the correct value
- You have to change the name and the description of the program in the `KUPHeader` struct

Additional changes:

- In `pad_binary.py` you have to add the number of additional blocks to the variable `NUM_BLOCKS`
- In the `makefile` you have to change the value of the variable `BASIC_SOURCE` to the name of the BASIC program you want to store in flash

## Binary distribution

You will find  `cartridge.bin` together with `basic_01.bin` and `basic_02.bin` in the relase section of this repo.
