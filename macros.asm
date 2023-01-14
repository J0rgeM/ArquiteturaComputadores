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
