.data
inputtext: .asciiz "Give a number: "
oddtext: .asciiz "Number is odd"
eventext: .asciiz "Number is even"

.text
# read integer 
la $a0, inputtext
li $v0, 4 # print string
syscall

li $v0, 5 # read integer
syscall

move $t0, $v0 # copy read integer 
li $t1, 2

div $t0, $t1 # calculate quotient
mfhi $a0 # put reminder in $a0

beq $zero, $a0 evenumber # if reminder is 0 it is even, goto evenumber
 #else goto oddnumber
 
oddnumber:
la $a0, oddtext
li $v0, 4
syscall
j endprog # jump end of program

evenumber:
la $a0, eventext
li $v0, 4
syscall

endprog:
li $v0, 10
syscall