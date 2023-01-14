#

.eqv n 3 # number of independent variables

.data 

array: .float
	2.0, 1.0, -3.0, -1.0,
	-1.0, 3.0, 2.0, 12.0,
	3.0, 1.0, -3.0, 0.0
	
.text

jal factorial

move $a0, $v0	#
li $v0, 1	# print result
syscall		#

li $v0, 10	# terminate program	
syscall		#

########################## FUNCTIONS #############################

