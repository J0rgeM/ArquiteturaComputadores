.data 
input: .asciiz "Give a number: "
sum: .asciiz "The sum is: "
difference: .asciiz "The difference is: "
product: .asciiz "The product is: "
quocient: .asciiz "The quocient is: "
newline: .asciiz "\n"

.text
la $a0, input
li $v0, 4    # print_string input
syscall

li $v0, 5 #input 1 
syscall
move $t0,$v0 #guarda input 1

la $a0, input
li $v0, 4     #print_string input
syscall      

li $v0, 5 #input 2
syscall
move $t1,$v0 #guarda input 2

add $t2,$t0,$t1 #soma input 1 + input 2 e guarda no registro $t2    $t2 = $t0 + $t1

la $a0, sum
li $v0, 4    #print_string soma
syscall

move $a0,$t2

li $v0 1 #print soma
syscall

li $v0, 4
la $a0, newline
syscall

sub $t3,$t0,$t1 #subtrai input 1 - input 2 e guarda no registro $t3   $t3 = $t0 - $t1

la $a0, difference
li $v0, 4    #print_string difference
syscall

move $a0,$t3

li $v0 1 #print subtracao
syscall

la $a0, newline
li $v0, 4 
syscall

mul $t4,$t0,$t1 #multiplica input 1 * input 2 e guarda no registro $t4   $t4 = $t0 * $t1

la $a0, product
li $v0, 4    #print_string product
syscall

move $a0,$t4

li $v0 1 #print multiplicacao
syscall

la $a0, newline
li $v0, 4 
syscall

div $t5,$t0,$t1 #divsao input 1 / input 2 e guarda no registro $t5   $t5 = $t0 / $t1

la $a0, quocient
li $v0, 4    #print_string quocient
syscall

move $a0,$t5

#hi resto
#lo quociente

li $v0 1 #print divisao
syscall

#terminate program
li $v0,10 #system call for exit
syscall
