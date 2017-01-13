.globl linux_read
.type linux_read, %function
linux_read:
push    {%r7}
mov     %r7, $3
swi     $0
pop     {%r7}
cmp     %r0, $0
bxcc      %lr 
movw    %r3, #:lower16:errno
movt    %r3, #:upper16:errno
neg %r0, %r0
str     %r0, [%r3]
mov     %r0, $-1
bx %lr
