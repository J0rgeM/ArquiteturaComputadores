.data

give: .asciiz "Give a number: " 
result: .asciiz "Result: "
newline: .asciiz "\n"

.text

la $a0 give 
li $v0 4
syscall

li $v0, 5 #input
syscall   #

move $t0,$v0

la $a0 give 
li $v0 4
syscall

li $v0, 5 #input
syscall  #

move $t1 $v0

add $t2 $t0 $t1 

la $a0 result 
li $v0 4
syscall

move $a0 $t2

li $v0 1
syscall # syscall 1 print int

#terminate program
li $v0 10
syscall