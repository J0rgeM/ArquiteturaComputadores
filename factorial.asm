.data 
 input: .asciiz "Input number: "
 result: .asciiz "Result: "

.text
la $a0 input	#
li $v0 4      	# 
syscall       	#
             	# input 
li $v0 5     	#
syscall      	# 
move $a0 $v0  	#

jal factorial

move $a0, $v0	#
li $v0, 1	# print result
syscall		#

li $v0, 10	# terminate program	
syscall		#

factorial:
	li $v0 1
	beqz $a0, exit		# 0! = 1
	addi $a0,$a0 -1
	
	addi $sp,$sp, -4	# push $ra to stack
	sw $ra,($sp)		#
	
	jal factorial		# (n-1)!
	
	lw $ra,($sp)		# pop $ra to stack
	addi $sp,$sp 4		#
	
	addi $a0,$a0 1
	mul $v0,$v0,$a0		# n*(n-1)!
exit:
	jr $ra
