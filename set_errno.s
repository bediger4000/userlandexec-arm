.globl set_errno
.type set_errno, %function
set_errno:
movw    %r4, #:lower16:errno
movt    %r4, #:upper16:errno
str     %r0, [%r4]
add %r0, %r0, #1
bx %lr
