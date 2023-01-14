.data

text: .asciiz "Loopin'"

.text

li $s0 10	# numero de vezes para correr o loog

startFor:
beqz $s0 endFor		# se o numero de vezes for 0, salta

li $v0 4	#
la $a0 text	# imprimir o texto
syscall		#

subi $s0 $s0 1	# subtrair 1 do numero de vezes

j startFor

endFor:
