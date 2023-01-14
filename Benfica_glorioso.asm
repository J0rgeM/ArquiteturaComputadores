.data
benfica: .asciiz "Benfica, o glorioso! "
input: .asciiz "Give a number: "
newline: .asciiz "\n"

.text
la $a0, input #
li $v0, 4     # print_string input
syscall       #

li $v0, 5    #
syscall      # input
move $t1,$v0 #

move $t0, $zero

start:
	beq $t0, $t1, exitloop
	la $a0, benfica  #
	li $v0, 4        #
	syscall          #
	                 # print Benfica e newline
	la $a0, newline  # 
	li $v0, 4        #
	syscall          #
	
	move $a0 $t0
	
	addi $t0, $t0, 1 # incrementa o loop
	j start
exitloop:

#terminate program
li $v0,10 
syscall
