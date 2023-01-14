.data
input: .asciiz "Give a number: "
result: .asciiz "The answer is: "

.text
la $a0, input #
li $v0, 4     # print_string input
syscall       #

li $v0, 5    #
syscall      # input 1
move $s1,$v0 #

la $a0, input #
li $v0, 4     # print_string input
syscall       #

li $v0, 5    #
syscall      # input 2
move $s2,$v0 #

# In: $s1 = multiplier, $s2 = multiplicand
# Out: $t0 = result
move $t0,$zero      # result
mult_loop:
    andi $t2,$s2,1
    beq $t2,$zero, shift # if (multiplicand & 1)
    addu $t0,$t0,$s1  #  result += multiplier << shift
    
shift:
    sll $s1,$s1,1     # multiplier <<= 1
    srl $s2,$s2,1     # multiplicand >>= 1
    bne $s2,$zero, mult_loop
   
la $a0, result #
li $v0, 4     # print_string input
syscall       #

move $a0, $t0

li $v0 1 
syscall

 #terminate program
 li $v0, 10
 syscall
