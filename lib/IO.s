.section .data
# flags
O_RDONLY:   .quad 0     # 0b00000000
O_WRONLY:   .quad 1     # 0b00000001
O_RDWR:     .quad 2     # 0b00000010
O_CREAT:    .quad 100   # 0b01100110
O_EXCL:     .quad 200   # 0b11001000
O_NOCTTY:   .quad 400   # 0b110010000
O_TRUNC:    .quad 1000  # 0b1111101000

# modes
S_IXUSR:    .quad 100   # 0b01100110
S_IWUSR:    .quad 200   # 0b11001000
S_IRUSR:    .quad 400   # 0b110010000
S_IRWXU:    .quad 700   # 0b1010111100

S_IXGRP:    .quad 10    # 0b00001010
S_IWGRG:    .quad 20    # 0b00010100
S_IRGRG:    .quad 40    # 0b00101000
S_IRWXG:    .quad 70    # 0b01000110

S_IXOTH:    .quad 1     # 0b00000001
S_IWOTH:    .quad 2     # 0b00000010
S_IROTH:    .quad 4     # 0b00000100
S_IRWXO:    .quad 7     # 0b00000111

newln: .ascii "\n"

.macro read fd, loc, len
    movq \fd, %rdi
    leaq \loc, %rsi
    movq \len, %rdx
    movq $0, %rax
    syscall
.endm

.macro open file, flags, mode
    movq \file, %rdi
    movq \flags, %rsi
    movq \mode, %rdx
    movq $2, %rax
    syscall
.endm

.macro close fd
    movq \fd, %rdi
    movq $4, %rax
    syscall
.endm

.macro newline fd
    movq \fd, %rdi
    leaq newln(%rip), %rsi
    movq $1, %rdx
    movq $1, %rax
    syscall
.endm

.macro write fd, str, len
    movq \fd, %rdi
    leaq \str, %rsi
    movq \len, %rdx
    movq $1, %rax
    syscall
.endm

.macro writeln fd, str, len
    write \fd, \str, \len
    newline \fd
.endm

.macro print str
    leaq \str, %rdi
    call strlen
    write $1, \str, %rax
.endm

.macro println str
    leaq \str, %rdi
    call strlen
    writeln $1, \str, %rax
.endm

.macro fatalln str, status
    println \str
    movq \status, %rdi
    movq $60, %rax
    syscall
.endm

.macro exit status
    movq \status, %rdi
    movq $60, %rax
    syscall
.endm

.global     strlen
.section	.text
	.type	strlen, @function
strlen:
	pushq	%rbp
	movq	%rsp, %rbp

    pushq   %r8
	movq	%rdi, %r8
	jmp	.L0
.L1:
	addq	$1, %r8
.L0:
	movq	%r8, %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L1

	movq	%r8, %rax
	subq	%rdi, %rax
    popq    %r8
	popq	%rbp
	ret

