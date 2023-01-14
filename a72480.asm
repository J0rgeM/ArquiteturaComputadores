# Trabalho realizado por: 
# Francisco Eduardo Aguas Lopes a71391
# Jorge Miguel Vieira da Silva a72480

.eqv startx -6
.eqv stopx 6.28318
.eqv n 100
.eqv dx 0.0001

.data 
x: .asciiz "x"
senx: .asciiz "sen(x)"
cosx: .asciiz "cos(x)"
tanx: .asciiz "tan(x)"
space: .asciiz " "
slashes: .asciiz "----------------------"
enter: .asciiz "\n"
zero: .float 0
dx1: .float 0.0001
piunder2: .float 1.570796326
pi: .float 3.1415926
pitimes2: .float 6.28318 
stopxmax: .float stopx
numberstart: .float startx

###############################
# MIPS Assembly maros #
# maros.asm #
###############################
.macro push %reg
	addiu $sp, $sp, -4
	sw %reg, 0($sp)
.end_macro

.macro pushf %reg
	addiu $sp, $sp, -4
	swc1 %reg, 0($sp)
.end_macro


.macro pop %reg
	lw %reg, 0($sp)
	addiu $sp, $sp, 4
.end_macro

.macro popf %reg
	lwc1 %reg, 0($sp)
	addiu $sp, $sp, 4
.end_macro


.macro in %reg
	addi %reg, %reg, 1
.end_macro


.macro de %reg
	addi %reg, %reg, -1
.end_macro


.macro done
	li $a0, 0
	li $v0, 17
	syscall
.end_macro

.text
main:

	jal print_start
	lwc1 $f15 stopxmax 
	
	li $s1 0 	
	li $s2 n
	mtc1 $s2 $f17 # number of elements
	cvt.s.w $f17 $f17
	
	lwc1 $f19 numberstart
	
	loopin:
	beq $s1 n endloopin # $s1 = i
	
	mtc1 $s1 $f16
	cvt.s.w $f16 $f16
	
	mul.s $f0 $f16 $f15 # $f0 = i * max_number
	div.s $f0 $f0 $f17 # $f0 = $f0/ n	
	add.s $f0 $f0 $f19 # $f0 = $f0 + numberstart	
	
	mov.s $f12 $f0
	li $v0 2
	syscall
	
	la $a0 space
	li $v0 4
	syscall
	
	mfc1 $a1 $f0
	pushf $f0
	pushf $f8
	pushf $f9
	pushf $f11
	pushf $f18
	push $s0
	push $t7
	jal taylor_series
	pop $t7
	pop $s0
	popf $f18
	popf $f11
	popf $f9
	popf $f8
	popf $f0
	
	la $a0 enter
	li $v0 4
	syscall
	
	addi $s1 $s1 1
	
	j loopin
	endloopin:
#terminate program
done	

taylor_series:
	mtc1 $a1 $f0
	
	mfc1 $a1 $f0
	push $ra
	pushf $f0
	pushf $f1
	pushf $f2
	pushf $f13
	pushf $f14
	push $t0
	push $t6
	# will see if number is less than 0 or bigger than 2pi
	jal check_condition_ofsin
	pop $t6
	pop $t0
	popf $f14
	popf $f13
	popf $f2
	popf $f1
	popf $f0
	pop $ra
	
	mtc1 $v0 $f0
	
	lwc1 $f18 pi
	# if x is > 2pi, set $s0 = 1
	c.le.s $f18 $f0
	bc1f lessthanpi 
		sub.s $f0 $f0 $f18
		li $s0 1	
	lessthanpi:
	
	mfc1 $a1 $f0
	
	push $ra
	push $t0
	push $t2
	pushf $f0
	pushf $f2
	pushf $f3
	pushf $f4
	pushf $f5
	pushf $f6
	pushf $f7
	jal sinx
	mtc1 $v0 $f9 # $f9 = sin(x)
	
	move $t7 $v1 # $t7 comes from check condition, if condition is met $t7 = 1
	bne $t7 1 dontuploadneg # $f9 = -($f9)
		neg.s $f9 $f9	
	dontuploadneg:
	
	bne $s0 1 lessthanpi2 # if x > pi, $f9 = -($f9)
		neg.s $f9 $f9
	lessthanpi2:

	mov.s $f12 $f9
	li $v0 2
	syscall
	
	popf $f7
	popf $f6
	popf $f5
	popf $f4
	popf $f3
	popf $f2
	popf $f0
	pop $t0
	pop $t2	
	pop $ra
	
	la $a0 space
	li $v0 4
	syscall
	
	# cos(x) = sin(pi/2 - x)
	lwc1 $f8 piunder2
	
	sub.s $f0 $f8 $f0 # $f0 = (pi/2) - x
	mfc1 $a1 $f0
	
	push $ra
	pushf $f0
	pushf $f1
	pushf $f2
	pushf $f13
	pushf $f14
	push $t0
	push $t6
	jal check_condition_ofsin # is equal to last one
	pop $t6
	pop $t0
	popf $f14
	popf $f13
	popf $f2
	popf $f1
	popf $f0
	pop $ra
	
	mtc1 $v0 $f0
	mfc1 $a1 $f0
	
	push $ra
	push $t0
	push $t2
	pushf $f0
	pushf $f2 
	pushf $f3
	pushf $f4
	pushf $f5
	pushf $f6
	pushf $f7
	
	jal sinx
	mtc1 $v0 $f10 # $f10 = result of sin((pi/2)-x)
	move $t7 $v1 
	bne $t7 1 dontuploadnegv2 # is equal to the last one
		neg.s $f10 $f10	
	dontuploadnegv2:
	
	bne $s0 1 lessthanpi3 # x < pi
		neg.s $f10 $f10
	lessthanpi3:
	
	mov.s $f12 $f10
	li $v0 2
	syscall
	
	popf $f7
	popf $f6
	popf $f5
	popf $f4
	popf $f3
	popf $f2
	popf $f0
	pop $t0
	pop $t2	
	pop $ra
	
	la $a0 space
	li $v0 4
	syscall
	
	div.s $f11 $f9 $f10 # $f11 = tan(x)
	mov.s $f12 $f11
	li $v0 2
	syscall
			
jr $ra

# $t6 if its negative = 1 else = 0
check_condition_ofsin:
	mtc1 $a1 $f0
	lwc1 $f1 zero
	li $t6 0
	
	c.le.s $f0 $f1
	bc1f notnegative
		neg.s $f0 $f0
		addi $t6 $t6 1
	notnegative:
	
	lwc1 $f2 pitimes2
	
	# this will see if number is bigger than 2*pi and convert it to a number between 0 and 2*pi
	c.le.s $f2 $f0
	bc1f notbigger2pi
		div.s $f13 $f0 $f2
		# converts de division of x by 2*pi to a int number and then converts to a float so it can than convert the x to a number between 0 and 2*pi
		cvt.w.s $f13 $f13
		cvt.s.w $f13 $f13
		mul.s $f14 $f2 $f13
		sub.s $f0 $f0 $f14
		
	notbigger2pi:
	
	move $v1 $t6
	mfc1 $v0 $f0

jr $ra

# fuction sin(x)
# $f0 = x
# $t0 = n
# $t2 = 2n+1
# $f2 = x^(2n+1)
# $f3 = n!
# $f4 = $f2 / $f3
# $f5 if n is even = $f4 else -($f4)
# $f6 = dx1
# $f7 = summation of $f5
# $t5 = mask if its even or odd

sinx:
	mtc1 $a1 $f0
	lwc1 $f6 dx1
	li $t0 0
	
	check_element:
	# will get the number of element	
	mul $t2 $t0 2		
	addi $t2 $t2 1
	
	# will get the element that will be the exponencial to the x
	mfc1 $a1 $f0
	move $a2 $t2		
	
	push $ra
	pushf $f0 
	pushf $f1
	push $t3
	jal expoente
	pop $t3
	popf $f1
	popf $f0
	pop $ra
	
	mtc1 $v0 $f2
	
	push $ra 
	move $a1 $t2
	push $t3
	push $t4
	jal factorial
	pop $t4
	pop $t3
	pop $ra
	
	mtc1 $v0 $f3
	cvt.s.w $f3 $f3
	
	# exponencial / factorial
	div.s $f4 $f2 $f3
	mov.s $f5 $f4
	
	# mask to see if n its even or odd
	andi $t5 $t0 1
	beqz $t5 par	
	neg.s $f5 $f5
	
	par:
	
	addi $t0 $t0 1	
	add.s $f7 $f7 $f5	
	beq $t0 6 exit_loop #exit so it doesn't overflow	
	c.le.s $f4 $f6
	bc1f check_element
	
	exit_loop:
	
	mfc1 $v0 $f7
	
jr $ra

# fuction exponencial x^(2n+1)
# $f0 = x
# $t3 = 2n+1
# $f1 = result
expoente:
	mtc1 $a1 $f0
	mtc1 $a1 $f1
	move $t3 $a2
	subi $t3 $t3 1 # because $f1 gets the value of $f0 so $t3 needs to be subtracted 1
	
	expoente_loop:
	
	beqz $t3 exit_expoente_loop
	mul.s $f1 $f1 $f0		
	subi $t3 $t3 1
	j expoente_loop
	
	exit_expoente_loop:
	mfc1 $v0 $f1
jr $ra

# fuction factorial
# $t3 = (2*n)+1
# $t4 first element of $t3

factorial:

	move $t3 $a1
	move $t4 $t3
	subi $t3 $t3 1 # substract so $t4 gets first element of $t3
	
	factorial_loop:
	
	beqz $t3 exit_factorial_loop
	mul $t4 $t4 $t3
	subi $t3 $t3 1
	j factorial_loop
	
	exit_factorial_loop:
	move $v0 $t4
jr $ra

# prints the result of sin(x)
print_start:

	la $a0 x
	li $v0 4
	syscall
	
	la $a0 space
	li $v0 4
	syscall
	
	la $a0 senx
	li $v0 4
	syscall
	
	la $a0 space
	li $v0 4
	syscall
	
	la $a0 cosx
	li $v0 4
	syscall
	
	la $a0 space
	li $v0 4
	syscall
	
	la $a0 tanx
	li $v0 4
	syscall
	
	la $a0 enter
	li $v0 4
	syscall
	
	la $a0 slashes
	li $v0 4
	syscall
	
	la $a0 enter
	li $v0 4
	syscall
	
jr $ra
