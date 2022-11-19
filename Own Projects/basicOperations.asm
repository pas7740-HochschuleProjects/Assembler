.data

.text
	.globl CallerSave
	CallerSave:
		addi $sp, $sp, -64
		
		sw $v0, 60($sp)
		sw $v1, 56($sp)
		sw $a0, 52($sp)
		sw $a1, 48($sp)
		sw $a2, 44($sp)
		sw $a3, 40($sp)
		sw $t0, 36($sp)
		sw $t1, 32($sp)
		sw $t2, 28($sp)
		sw $t3, 24($sp)
		sw $t4, 20($sp)
		sw $t5, 16($sp)
		sw $t6, 12($sp)
		sw $t7, 8($sp)
		sw $t8, 4($sp)
		sw $t9, 0($sp)
		
		jr $ra
		
	.globl CallerRestore
	CallerRestore:
		lw $v0, 60($sp)
		lw $v1, 56($sp)
		lw $a0, 52($sp)
		lw $a1, 48($sp)
		lw $a2, 44($sp)
		lw $a3, 40($sp)
		lw $t0, 36($sp)
		lw $t1, 32($sp)
		lw $t2, 28($sp)
		lw $t3, 24($sp)
		lw $t4, 20($sp)
		lw $t5, 16($sp)
		lw $t6, 12($sp)
		lw $t7, 8($sp)
		lw $t8, 4($sp)
		lw $t9, 0($sp)
		
		addi $sp, $sp, 64
		jr $ra
		
	.globl CalleeSave
	CalleeSave:
		addi $sp, $sp, -32
		
		sw $s0, 28($sp)
		sw $s1, 24($sp)
		sw $s2, 20($sp)
		sw $s3, 16($sp)
		sw $s4, 12($sp)
		sw $s5, 8($sp)
		sw $s6, 4($sp)
		sw $s7, 0($sp)
		
		jr $ra
	
	.globl CalleeRestore
	CalleeRestore:
		lw $s0, 28($sp)
		lw $s1, 24($sp)
		lw $s2, 20($sp)
		lw $s3, 16($sp)
		lw $s4, 12($sp)
		lw $s5, 8($sp)
		lw $s6, 4($sp)
		lw $s7, 0($sp)
		
		addi $sp, $sp, 32
		jr $ra
		
	# Time in milliseconds in $a0
	.globl Sleep
	Sleep:
		li $v0, 32
		syscall
		jr $ra
