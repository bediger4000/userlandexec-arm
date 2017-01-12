@ Software simulation of 32 bit unsigned integer division
@ Entry  r0: numerator (lo) must be signed positive
@      r6: denominator (den) must be non-zero and signed negative
@ int idiv0(long numerator, long denominator)

      lo .req r0; hi .req r5; den .req r6
.globl idiv0
.type idiv0, %function
idiv0:
mov %r4, #0 @ hi = 0
adds %r5, %r5, %r5
.rept 32 @ repeat 32 times
	adcs %r4, %r6, %r4, lsl #1
	subcc %r4, %r4, %r6
	adcs %r5, %r5, %r5
.endr
bx %lr
