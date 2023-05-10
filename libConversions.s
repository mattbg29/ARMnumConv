# FileName: libConversions.s
# Author: Matthew Green
# Date: 11/14/2022
# Purpose: Functions for use on Module 11 assignment

.global multPos

###########################
# Function: mult
# Purpose: to multiply two numbers together using recursion, where the second number is positive
# Input: r0, r1: the 2 numbers to multiply
# Output: r0 - a pointer to the product of the two numbers

.text 
multPos:
    # program dictionary:
    #    r4 - the first number to multiply, which stays constant
    #    r5 - the second number to multiply, which decrements with each recursive call

    # push and store r4, r5 so that we can safely use these for our inputs
    SUB sp, sp, #12
    STR lr, [sp]
    STR r4, [sp, #4]
    STR r5, [sp, #8]

    # safely store r0, r1 into r4, r5
    MOV r4, r0
    MOV r5, r1

    # if the second number has reduced to 1, return the first number by storing r4 in r0
    MOV r1, #1
    CMP r5, r1
    BNE Else
        MOV r0, r4
        B Return

    # if the second number is greater than 1, subtract 1 and store in r1, 
    # then call mult with original r4 and decremneted r5 as r0, r1 
    Else:
        SUB r1, r5, #1
        MOV r0, r4 // Not technically necessary, as r4 is already in r0, but I think good practice 
        BL multPos
        ADD r0, r4, r0 // once we return here, add the return value, r0, to r4 and store in r0 to be returned 
        B Return

    Return:

    # pop
    LDR lr, [sp] 
    LDR r4, [sp, #4]
    LDR r5, [sp, #8]
    ADD sp, sp, #12
    MOV pc, lr

.data

#END multPos


.global multNeg

###########################
# Function: multNeg
# Purpose: to multiply two numbers together using recursion when the second number is negative.
#	   This will return the inverse of the correct result, which has to be addresed by the
#	   proram that calls it. 
# Input: r0, r1: the 2 numbers to multiply
# Output: r0 - a pointer to the product of the two numbers

.text 
multNeg:
    # program dictionary:
    #    r4 - the first number to multiply, which stays constant
    #    r5 - the second number to multiply, a negative, which increments with each recursive call

    # push and store r4, r5 so that we can safely use these for our inputs
    SUB sp, sp, #12
    STR lr, [sp]
    STR r4, [sp, #4]
    STR r5, [sp, #8]

    # safely store r0, r1 into r4, r5
    MOV r4, r0
    MOV r5, r1

    # if the second number has reduced to 1, return the first number by storing r4 in r0
    MOV r1, #-1
    CMP r5, r1
    BNE Else2
        MOV r0, r4
        B Return2

    # if the second number is greater than 1, subtract 1 and store in r1, 
    # then call mult with original r4 and decremneted r5 as r0, r1 
    Else2:
        ADD r1, r5, #1
        MOV r0, r4 // Not technically necessary, as r4 is already in r0, but I think good practice 
        BL multNeg
        ADD r0, r4, r0 // once we return here, add the return value, r0, to r4 and store in r0 to be returned 
        B Return2

    Return2:

    # pop
    LDR lr, [sp] 
    LDR r4, [sp, #4]
    LDR r5, [sp, #8]
    ADD sp, sp, #12
    MOV pc, lr

.data

#END multNeg


.global fib

###########################
# Function: fib
# Purpose: To calculate the Fionacci number recursively, defined as an = a(n-1) + a(n-2)
# Input: r0: the number n to calculate to calculate the Fibonacci number, an,  on (see Purpose above)
# Output: r0 - a pointer to the sum of the Fibonacci number

.text 
fib:
    # program dictionary:
    #    r4 - the fibonacci number, which decrements by 1 and 2 with each recursive call
    #    r5 - to store the output of the first recursive call to fib

    # push and store r4, r5 so that we can safely use these for our inputs
    SUB sp, sp, #12
    STR lr, [sp]
    STR r4, [sp, #4]
    STR r5, [sp, #8]

    # safely store r0 into r4
    MOV r4, r0

    # if n  has reduced to below 2, return 1, else branch to Else2
    MOV r3, #1
    CMP r4, r3
    BGT Else3
        MOV r0, #1
        B Return3

    # recursively call fib with n-1, then again with n-2, and return the sum of the two outputs
    Else3:
        SUB r0, r4, #1
        BL fib
        MOV r5, r0 // store the output of the first call in r5, to be combined with the second output

        SUB r0, r4, #2
	BL fib
        ADD r0, r0, r5 
        B Return3

    Return3:

    # pop
    LDR lr, [sp] 
    LDR r4, [sp, #4]
    LDR r5, [sp, #8]
    ADD sp, sp, #12
    MOV pc, lr

.data

#END fib
