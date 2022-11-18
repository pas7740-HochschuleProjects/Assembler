.data

.text
	.globl Loop
	Loop:
		jr $ra
		
	.globl PushStack
	PushStack:
		addiu $sp, $sp, -4
		sw $ra, 0($sp)
		jr $ra
	
	.globl PopStack
	PopStack:
		lw $ra, 0($sp)
		addiu $sp, $sp, 4
		jr $ra
