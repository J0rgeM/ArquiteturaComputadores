.data

inputSeven: .asciiz "Escreva o numero 7: "

.text

li $t1 7	# carregar o 7 para ser comparado

startLoop:

beq $t0 $t1 endLoop	# se o valor lido for igual a 7, sai do loop

li $v0 4		#
la $a0 inputSeven	# escrever o texto inputSeven
syscall			#

li $v0 5	# ler da consola um inteiro
syscall		#

move $t0 $v0	# mexer o valor lido para ser comparado
j startLoop

endLoop:

