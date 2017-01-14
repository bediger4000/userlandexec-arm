# userlandexec-arm
## userland exec for Linux ARMv7

This code emulates an `exec()` system call. That is, it reads an ELF format file,
and loads it into memory at the correct address. It then starts the newly-loaded
executable to running.

All this is usually done by the Linux kernel, so some bizarre things go on.
For starters, the userland exec unmaps the currently-executing ELF file,
so as to be able to put the new ELF file's contents in the right place
in memory.

I was inspired to do this by The Grugq. I did start with his [userland exec](https://github.com/grugq/grugq.github.com/blob/master/docs/ul_exec.txt) to do the x86_64 version.

This code works with 32-bit Rasberry Pi 2 Linux ELF files, compiled with
GCC and linked against glibc. Specifically, I used Rasberry Pi Arch Linux,
kernel 4.4.41, GCC 6.2.1, GNU binutils 2.27.

I started out with my own [userland exec for x86_64](https://github.com/bediger4000/userlandexec),
v1.0 and modified it for ARM. I found it easier to do assembly language `crt.o` and system calls
in ARM assembly, rather than do the `asm()` GCC directives I used for x86_64 `userlandexec`.
A better programmer than I could have just interwoven ARM and x86_64 into the same project.

### Building

Run `make` - that should compile `example` and `ulexec.so`. Once you've
done that, you can try it out: 

`./example  ./ulexec.so  /usr/bin/cat /proc/self/maps`

### Test Programs

I wrote a large number of test and exploration programs. I included some of these in this
project. I wrote some programs (`getaux` and `elfauxv` for example) to understand how
the details of ELF files and Linux in-memory process layouts work. I wrote others in order
to understand things, like how to do system calls in assembly language, and how to do
position independent code. I had to write assembly code to call C program's `main()` routine
because I wanted to guarantee that my tests didn't use glibc at all. Once I converted the
assembly language system call code into ARM assembly, and made it position independent, I had
to convert the test programs that used that system call code into position independent compiled code.

Show the ELF auxiliary vectors:

    $ LD_SHOW_AUXV=1 ./getaux
    $ ./elfauxv

The first program uses glibc extension `getauxval(3)`, and has the dynamic linker
dump out the auxiliary vectors, for your inspection. These programs helped debug code in 
`stack_fix.c`. It isn't well documented, but the dynamic linker uses some of the
ELF auxiliary vector elements before your ELF file code gets executed. This auxiliary
vector must be set up correctly.

This project has a corresponding completely statically-linked program, `elfauxv`. It's easier
to do a userland exec for statically linked programs, so `elfauxv` helped me get creating
a new stack for a new ELF file correct before I got the code to work on dynamically linked
programs.

Try out `open(2)`, setting `errno` and `close(2)`:

    $ make oc
    $ ./oc somegibberish

It's easy to get `open(2)` to fail in a variety of ways by trying to open non-existent
files, removing read permissions, etc. The actual userland exec code has to be position
independent, so setting `errno` in ARM assembly became harder. This lets me try out 
posistion-indedepent assembly language code.

Find the environment variables:

    $ make env_test
    $ ./env_test

The userland exec creates copies of `argv` and `envp`. This just prints addresses
and environment variables to ensure that the "C run time" code in `libstatic/crt.s`
does `argc`, `argv` and `envp` correctly.

### Fun

`./example  ./ulexec.so  `./example  ./ulexec.so  `./example  ./ulexec.so  /usr/bin/cat /proc/self/maps`

Yes! You can have it overlay itself with another copy of itself.
