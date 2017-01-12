asm(
"       .text\n"
"       .globl  _start\n"
"       .align  2\n"
"_start:\n"
"       sub     lr, lr, lr\n"           // Clear the link register.
"       ldr     r0, [sp]\n"             // Get argc...
"       add     r1, sp, #4\n"           // ... and argv ...
"       add     r2, r1, r0, LSL #3\n"   // ... and compute environ.
"       bl      c_main\n"              // Let's go!
"       b       .\n"                    // Never gets here.
"       .size   _start, .-_start\n"
);
