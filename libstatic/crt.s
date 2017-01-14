.arm
.align 2
.globl _start
.type _start, %function
_start:
sub     %lr, %lr, %lr
ldr     %r0, [%sp]
add     %r1, %sp, #4
add     %r2, %r1, %r0, lsl #3
bl      c_main
b       .
.size   _start, .-_start
