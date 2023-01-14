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