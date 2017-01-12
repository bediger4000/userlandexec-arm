.globl unsigned_naive_div
.type unsigned_naive_div, %function
unsigned_naive_div:
@/* r0 contains N */
@/* r1 contains D */
    mov %r2, %r1             @/* r2 ← r0. We keep D in r2 */
    mov %r1, %r0             @/* r1 ← r0. We keep N in r1 */
 
    mov %r0, #0             @/* r0 ← 0. Set Q = 0 initially */
 
    b .Lloop_check2
    .Lloop2:
       add %r0, %r0, #1      @/* r0 ← r0 + 1. Q = Q + 1 */
       sub %r1, %r1, %r2      @/* r1 ← r1 - r2 */
    .Lloop_check2:
       cmp %r1, %r2          @/* compute r1 - r2 */
       bhs .Lloop2          @/* branch if r1 >= r2 (C=0 or Z=1) */
 
    @/* r0 already contains Q */
    @/* r1 already contains R */
    bx lr
.globl unsigned_naive_mod
.type unsigned_naive_mod, %function
unsigned_naive_mod:
@/* r0 contains N */
@/* r1 contains D */
    mov %r2, %r1             @/* r2 ← r0. We keep D in r2 */
    mov %r1, %r0             @/* r1 ← r0. We keep N in r1 */
 
    mov %r0, #0             @/* r0 ← 0. Set Q = 0 initially */
 
    b .Lloop_check
    .Lloop:
       add %r0, %r0, #1      @/* r0 ← r0 + 1. Q = Q + 1 */
       sub %r1, %r1, %r2      @/* r1 ← r1 - r2 */
    .Lloop_check:
       cmp %r1, %r2          @/* compute r1 - r2 */
       bhs .Lloop          @/* branch if r1 >= r2 (C=0 or Z=1) */
 
    @/* r0 already contains Q */
    @/* r1 already contains R */
    mov %r0, %r1
    bx lr
