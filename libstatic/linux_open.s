.globl linux_open
.type linux_open, %function
linux_open:
push    {%r7}
mov     %r7, $5
swi     $0
pop     {%r7}
cmn     %r0, $4096
bxcc      %lr 
ldr     %r2, .L3
.LPIC0:
add     %r2, %pc, %r2
ldr  %r3, .L3+4
ldr     %r3, [%r2, %r3]
neg %r0, %r0
str     %r0, [%r3]
mov     %r0, $-1
bx %lr
.align  2
.L3:
.word   _GLOBAL_OFFSET_TABLE_-(.LPIC0+8)
.word   errno(GOT)
.size   linux_open, .-linux_open
