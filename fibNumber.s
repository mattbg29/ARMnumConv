# FileName: fibNumber.s
# Author: Matthew Green
# Date: 11/14/2022
# Purpose: to calculate the Fibonacci number using a uer input and the external function fib
#          in libConversions

.text
.global main
main:
    # program dictionary:
    #    r0 - the input, n, to fib

    # push
    SUB sp, sp, #4
    STR lr, [sp]

    # prompt and scan n from user
    LDR r0, =prompt1
    BL printf
    LDR r0, =format
    LDR r1, =num1
    BL scanf

    # check if number is greater than 1; if not, return an error message and terminate
    LDR r0, =num1
    LDR r0, [r0]
    MOV r1, #1
    CMP r0, r1
    BLE InvalidEntry

        # entry is valid. load input and call fib
        LDR r0, =num1
        LDR r0, [r0]
        BL fib

        # move the function output (the Fibonacci number) to r1 and print the result
        MOV r1, r0
        LDR r0, =output
        BL printf
        B EndIf

    InvalidEntry: 
        LDR r0, =outputInvalid
        BL printf
        B EndIf

    EndIf:

    # pop
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt1: .asciz "Enter a number, n, grater than 1 to calculate the Fibonacci number on: "
    format: .asciz "%d"
    num1: .word 0
    output: .asciz "The Fibonacci Number is: %d\n"
    outputInvalid: .asciz "n must be greater than 1. Please try again.\n"
