.text
.globl linux_exit
.type linux_exit,%function
linux_exit:
    mov     %r7, $1
    swi     $0
