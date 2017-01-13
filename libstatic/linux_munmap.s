.globl linux_mmap
.type linux_mmap, %function
linux_mmap:
push    {%r7}
mov     %r7, $92
swi     $0
pop     {%r7}
cmn     %r0, $4096
bx      %lr 
movw    %r3, #:lower16:errno
movt    %r3, #:upper16:errno
str     %r0, [%r3]
mov     %r0, $-1
bx %lr
