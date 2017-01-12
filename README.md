# userlandexec
## userland exec for Linux ARMv7

This code emulates an `exec()` system call. That is, it reads an ELF format file,
and loads it into memory at the correct address. It then starts the newly-loaded
executable to running.

All this is usually done by the Linux kernel, so some bizarre things go on.
For starters, the userland exec unmaps the currently-executing ELF file,
so as to be able to put the new ELF file's contents in the right place
in memory.

This code works with 32-bit Rasberry Pi Linux ELF files, compiled with GCC and linked against glibc.

### Building

Run `make` - that should compile `example` and `ulexec.so`. Once you've
done that, you can try it out: 

`./example  ./ulexec.so  /usr/bin/cat /proc/self/maps`

### Test Programs

Show the ELF auxiliary vectors:

    $ LD_SHOW_AUXV=1 ./getaux
    $ ./elfauxv

The first program uses glibc extension `getauxval(3)`, and has dynmaic linker
also dump out the auxiliary vectors, for your inspection.

### Fun

`./example  ./ulexec.so  `./example  ./ulexec.so  `./example  ./ulexec.so  /usr/bin/cat /proc/self/maps`

Yes! You can have it overlay itself with another copy of itself.
