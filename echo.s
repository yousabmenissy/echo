/*
    This program is a very simple clone of the echo command.
    it loops through all the arguments a print them with spaces in between.
*/
.include "lib/sys_write.s"
.include "lib/sys_exit.s"

.section .data
usage: .string "Usage: echo [ arg... ]"
usage_len: .quad . - usage

space: .string " "

.section .text
.global _start
_start:
    movq %rsp, %rbp

    movq (%rbp), %r8      # r8 = argc
section0:
    cmpq $1, %r8
    je exit_usage         # if argc == 1, jump to exit_usage

    movq %rbp, %rbx
    addq $8, %rbx
section1:
.LP0:
    addq $8, %rbx
    movq (%rbx), %r9
    print (%r9)
    write $1, space(%rip), $1

    decq %r8
    cmpq $1, %r8
    jg .LP0               # if argc > 1, repeat the loop

exit_success:
    newline $1
    exit $0

exit_usage:
    writeln $1, usage(%rip), usage_len
    exit $-1
