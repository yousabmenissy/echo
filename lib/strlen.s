.section .text

# rdi holds the first argument
.global len
.type len, @function
len:
    pushq %rbp
    movq %rsp, %rbp

    pushq %rsi
    pushq %rcx
    movq $0, %rcx

sectionL0:
    movq %rdi, %rsi
.LPL0:
    lodsb
    cmpb $0, %al
    je .LLL
    incq %rcx
    jmp .LPL0

.LLL0:
    movq %rcx, %rax
    popq %rcx
    popq %rsi
    leave
    ret
