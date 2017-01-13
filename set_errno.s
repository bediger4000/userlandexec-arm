.globl set_errno
.type set_errno, %function
set_errno:
movw    %r3, #:lower16:errno
movt    %r3, #:upper16:errno
str     %r0, [%r3]
add %r0, %r0, #1
bx %lr
