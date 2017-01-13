.globl linux_sbrk
.type linux_sbrk, %function
linux_sbrk:
push    {%r7}
mov     %r7, $45
swi     $0
pop     {%r7}
cmn     %r0, $4096
bx      %lr 
movw    %r3, #:lower16:errno
movt    %r3, #:upper16:errno
str     %r0, [%r3]
mov     %r0, $-1
bx %lr
