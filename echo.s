/*
    This program is a very simple clone of the echo command.
    it loops through all the arguments a print them with spaces in between.
*/
.include "lib/strlen.s"
.include "lib/sys_write.s"
.include "lib/sys_exit.s"

.section .data
usage: .string "Usage: echo [ arg... ]"
usage_len: .quad . - usage

.section .text
.global _start
_start:
    movq %rsp, %rbp
    subq $8, %rsp

    movq (%rbp), %rbx       # rbx hold the number of the arguments(i.e. argc)
    movq %rbx, -8(%rbp)     # save argc to the stack

section0:
    cmpq $1, %rbx
    je exit_error           # if argc == 1, jump to exit_error

    movq %rbp, %rbx         # copy of the current value of rbp
    addq $8, %rbx           # skip argv[0], the name of the file

section1:
.LP0:
    addq $8, %rbx           # rbx = argv[1]
    movq (%rbx), %rdi
    call strlen             # strlen calculate the length of the argument
    write $1, (%rdi), %rax  # the sys_write file contain the write, writes, writeln macros
    writes $1

    decq -8(%rbp)           # --argc
    cmpq $1, -8(%rbp)
    jg .LP0                 # if argc > 1, repeat the loop

# write new line and exit
    writeln $1
    exit $0                 # the file sys_exit contain the exit macro

# will only run if the program was run without arguments(i.e. argc == 1)
exit_error:
    write $1, usage(%rip), usage_len
    writeln $1
    exit $-1
