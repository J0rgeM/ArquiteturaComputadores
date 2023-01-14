.data

first: .asciiz " - Primeiro é maior"
second: .asciiz " - Segundo é maior"

.text

li $v0 5
syscall

move $t0 $v0

li $v0 5
syscall

move $t1 $v0

ble $t0 $t1 second_greater

li $v0 1
move $a0 $t0
syscall

li $v0 4
la $a0 first
syscall

j exit

second_greater:

li $v0 1
move $a0 $t1
syscall

li $v0 4
la $a0 second
syscall

exit:

li $v0 10
syscall