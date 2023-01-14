# Trabalho realizado por: 
# Francisco Lopes a71391
# Jorge Silva a72480

.data
input_A: .asciiz "Operand A: "
input_B: .asciiz "Operand B: "
result: .asciiz "Result = "
plus: .asciiz " + "
division: .asciiz "/"

.text
# t0 = A 
# t1 = B 
# t2 = mask value 
# $s0 = Y 
# $s1 = X 
# $s2 = signal of A 
# $s3 = signal of B

la $a0 input_A				#
li $v0 4      				# 
syscall       				#
             				# Input A
li $v0 5     				#
syscall      				# 
move $t0 $v0  				#


la $a0 input_B				#
li $v0 4      				#
syscall       				#
              				# Input B
li $v0 5      				#
syscall        				#
move $t1 $v0 			        #

beqz $t1, endprog

lui $t2 0x8000				# This will be the mask maker, biggest positive number
				
blt $t0 $zero invert_A			# Checks if integer A is negative,
add $s2 $s2 $zero			# and stores 1 if its negative or 0 if positive into a new register
j check_B				# 
					# 
invert_A:				#  
	nor $t0 $t0 $zero		# 
	addi $t0 $t0 1			#
	addi $s2 $s2 1			# 

check_B:			
	blt $t1 $zero invert_B		# Checks if integer B is negative,
	add $s3 $s3 $zero		# and stores 1 if its negative or 0 if positive into a new register
	j start_division		# 
					#
invert_B:				# 
	nor $t1 $t1 $zero		# 
	addi $t1 $t1 1                  #
	addi $s3 $s3 1			# 
		
start_division:				 
	beqz $t2 exit_loop		# 
	and $t3 $t0 $t2			# we will mask A and see if diferrent than 0
	bne $t3 $zero sum1_X		# $t3 it will be the one to determine if X gets a 1 or a 0
	sll $s1 $s1 1			#
	j end_condition			
					
	sum1_X:				
		sll $s1 $s1 1		# $s1 will be the X of the division, this will be the one who gets the rests of the calculations
		addi $s1 $s1 1		#
					
	end_condition:			
		bge $s1 $t1 subtraction	# if $s1 > $t1 jump to subtract
		sll $s0 $s0 1		# $s0 will be the one to hold the quotient
		j check_endloop			
					
	subtraction:						
		sll $s0 $s0 1           # 
		addi $s0 $s0 1		# this block will make the subtraction, and shift then add 1 to Y
		sub $s1 $s1 $t1		#
		
	check_endloop:			
		srl $t2 $t2 1		
		j start_division	
				
exit_loop:
	beq $s2 $s3 print_positive	# if the number of A and B are positive jumps to print 
	nor $s0 $s0 $zero        	# else it will invert the number
	addi $s0 $s0 1 			#
	           		        #              	
	nor $s1 $s1 $zero       	#
	addi $s1 $s1 1          	#

# prints the result of the divison
print_positive:
	la $a0 result
	li $v0 4
	syscall

	move $a0 $s0
	li $v0 1
	syscall
	
	beqz $s1 endprog # if the rest is 0 endprog
	
	la $a0 plus
	li $v0 4
	syscall
	
	move $a0 $s1
	li $v0 1
	syscall
	
	la $a0 division
	li $v0 4
	syscall
	
	move $a0 $t1
	li $v0 1
	syscall

endprog:
li $v0,10 #terminate program
syscall
