.data
input: .asciiz "Give a number: "
different: .asciiz "Different"
equal: .asciiz "Some"

.text
la $a0, input #
li $v0, 4     # print_string input
syscall       #

li $v0, 5    #
syscall      # input 1
move $t0,$v0 #

la $a0, input #
li $v0, 4     # print_string input
syscall       #

li $v0, 5    #
syscall      # input 2
move $t1,$v0 #

beq $t0, $t1 equalnumber # if input 1 = input 2, goto equalnumber
#else goto differentnumber

differentnumber:
la $a0, different #
li $v0, 4         # print_different
syscall
j endprog          

 equalnumber:
 la $a0, equal #
 li $v0, 4     # print_equal
 syscall       #
 
 #terminate program
 endprog:
 li $v0, 10
 syscall
