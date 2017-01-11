.globl linux_read
.type linux_read, %function
linux_read:
push    {%r7}
mov     %r7, $3
swi     $0
pop     {%r7}
cmn     %r0, $4096
bx      %lr 
movw    %r4, #:lower16:errno
movt    %r4, #:upper16:errno
str     %r0, [%r4]
mov     %r0, $-1
bx %lr
