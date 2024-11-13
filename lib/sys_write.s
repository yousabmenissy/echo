.section .data
newline: .ascii "\n"
spacechar: .ascii " "
.macro write fd, str, len
    movq \fd, %rdi
    leaq \str, %rsi
    movq \len, %rdx
    movq $1, %rax
    syscall
.endm

.macro writeln fd
    movq $1, %rax
    movq \fd, %rdi
    leaq newline(%rip), %rsi
    movq $1, %rdx
    syscall
.endm

.macro writes fd
    movq $1, %rax
    movq \fd, %rdi
    leaq spacechar(%rip), %rsi
    movq $1, %rdx
    syscall
.endm
