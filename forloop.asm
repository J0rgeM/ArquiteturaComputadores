.data

string: .asciiz " Olá\n"

.text

li $t0 10
move $t1 $zero

loop:
beq $t0 $t1 exit

li $v0 1
move $a0 $t1
syscall

li $v0 4
la $a0 string
syscall

addi $t1 $t1 1
j loop
exit:

li $v0 10
syscall