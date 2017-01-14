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
v1.0 and modified for ARM. I found it easier to do assembly language `crt.o` and system calls
in ARM assembly, rather than do the `asm()` GCC directives I used for x86_64 `userlandexec`.
A better programmer than I could have just interwoven ARM and x86_64 into the same project.

### Building

Run `make` - that should compile `example` and `ulexec.so`. Once you've
done that, you can try it out: 

`./example  ./ulexec.so  /usr/bin/cat /proc/self/maps`

### Test Programs

Show the ELF auxiliary vectors:

    $ LD_SHOW_AUXV=1 ./getaux
    $ ./elfauxv

The first program uses glibc extension `getauxval(3)`, and has the dynamic linker
dump out the auxiliary vectors, for your inspection.

This project has a corresponding completely statically-linked program, `elfauxv`. It's easier
to do a userland exec for statically linked programs.

Try out `open(2)`, setting `errno` and `close(2)`:

    $ make oc
    $ ./oc somegibberish

It's easy to get `open(2)` to fail in a variety of ways by trying to open non-existent
files, removing read permissions, etc. The actual userland exec code has to be position
independent, so setting `errno` in ARM assembly became harder.

Find the environment variables:

    $ make env_test
    $ ./env_test

The userland exec creates copies of `argv` and `envp`. This just prints addresses
and environment variables to ensure that the "C run time" code in `libstatic/crt.s`
does `argc`, `argv` and `envp` correctly.

### Fun

`./example  ./ulexec.so  `./example  ./ulexec.so  `./example  ./ulexec.so  /usr/bin/cat /proc/self/maps`

Yes! You can have it overlay itself with another copy of itself.
