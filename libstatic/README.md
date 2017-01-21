# userlandexec-arm
## Statically-linked, position-independet C run time

Running `make` in this directory creates a statically-linkable,
position independent set of system calls and a few library routines
that you can use with a C program compiled for ARM v7

This code implements 10 system calls:
* read()
* write()
* open()
* close()
* exit()
* stat()
* brk()
* mmap()
* mprotect()
* munmap()

Each has its own ".s" file. Most of them set a global named `errno` to
indicate what problem the Linux kernel had with your system call's inputs.

The file `crt.s` sets the traditional `argc`, `argv` and `envp` variables
that a C program starts with.

There's a few utility routines like `memcpy()`, `strlen()`, `strchr()`,
`strcat()` and `strstr()`. A few very simple output functions exist.

These system calls allow the userland exec to do its work. They're written
or compiled as position independt code so that the finished shared object,
`ulexec.so`, can reside and execute from anywhere in a process' address space.

All of these functions are either used to create `ulexec.so`, do debugging,
or create some error run-time tracing output.


