#####################################################################
#    KIPS assembler program that prints "Hellow World        #
#                                    #
#####################################################################

.data
hellow: .asciiz "Hellow World\n"

.text
la $a0, hellow 
li $v0, 4    # 4: print string pointed to by $a0
syscall

move $t0, $v0

mylabel:
#terminate program
#li $v0,10 #system call for exit
#syscall
