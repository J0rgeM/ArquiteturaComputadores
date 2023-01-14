#Jorge Silva a72480

.data
input: .asciiz "Give a number: "
operand_a: .asciiz "Operand a: "
operand_b: .asciiz "Operand b: "
result: .asciiz "Result = "
plus: .asciiz "+ "
slash: .asciiz "/"
newline: .asciiz "\n"

.text
la $a0, input #
li $v0, 4     # print_string input
syscall       #

li $v0, 5    #
syscall      # a
move $s0,$v0 #

la $a0, input #
li $v0, 4     # print_string input
syscall       #

li $v0, 5    #
syscall      # b
move $s1,$v0 #

# s0: a  # s1: b  # t0: x  # t1: y

div_loop:
	sll $s0,$s0,31
	beqz $s0, inside_x # se valor no a for 1 dá shift e add mais 1 se for 0 sp da shift
	
	sll $s0,$s0,1 # left shift a
	sll $t0,$t0,1
	addi $t0,$t0,1	
	j exit_loop1 

inside_x:
	sll $s0,$s0,1 # left shift x

exit_loop1:
	bge $t0,$s1, shift # if (x >= b)
	
	sll $s0,$s0,1
	sll $t1,$t1,1
	j exit_loop2

shift:
	subu $t0,$t0,$s1 # sub b from x
	sll $t1,$t1,1 # left shift into y
	addi $t1,$t1,1 # add 1 into y

exit_loop2:
	beqz $s0, div_loop
	
	la $a0, result #
	li $v0, 4      # print_string input
	syscall        #

	move $a0, $t1
	li $v0 1 
	syscall
	
	move $a0, $t0
	li $v0 1 
	syscall

 #terminate program
 li $v0, 10
 syscall
