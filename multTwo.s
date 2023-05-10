# FileName: multTwo.s
# Author: Matthew Green
# Date: 11/14/2022
# Purpose: to multiply two ints and return the result using the external function
#          mult in libConversions

.text
.global main
main:
    # program dictionary:
    #    r0 - the first input number to mult
    #    r1 - the second input number to mult

    # push
    SUB sp, sp, #4
    STR lr, [sp]

    # prompt and scan 2 values from user to be multiplied
    LDR r0, =prompt1
    BL printf
    LDR r0, =format
    LDR r1, =num1
    BL scanf

    LDR r0, =prompt2
    BL printf
    LDR r0, =format
    LDR r1, =num2
    BL scanf

    # load inputs and call mult
    LDR r0, =num1
    LDR r0, [r0]
    LDR r1, =num2
    LDR r1, [r1]

    # if r1 is positive, call multPos, if negative, call multNeg, if 0, return 0
    MOV r2, #0
    CMP r1, r2
    BEQ Return0

    CMP r1, r2
    BLT MultiplyNegative

    # if here, r1 is a positive number
        BL multPos
        B EndIf

    MultiplyNegative:
        BL multNeg
        MOV r3, #0
        SUB r0, r3, r0 // multNeg returns the inverse of the correct result, so this is addressed here
        B EndIf

    Return0:
        MOV r0, #0
        B EndIf

    EndIf:

    # move the function output (the product) to r1 and print the result
    MOV r1, r0
    LDR r0, =output
    BL printf 

    # pop
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
    prompt1: .asciz "Enter the first number to multiply: "
    prompt2: .asciz "Enter the second number to multiply: "
    format: .asciz "%d"
    num1: .word 0
    num2: .word 0
    output: .asciz "The product is: %d\n"
