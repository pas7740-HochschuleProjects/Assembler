.data
.text
	.globl InitWorld
	InitWorld:
		la $s1, world
		li $t0, 0
		li $t1, -1	# Unused
		lw $t2, worldSize
		InitWorldLoop:
			add $t3, $t0, $s1
			sw $t1, 0($t3)
			add $t0, $t0, 4
			bne $t0, $t2, InitWorldLoop
		# Set First element
		sw $zero, 0($s1)
		
		jr $ra
	
	# x-Position in $a0, y-Position in $a1, WorldData in $a2
	.globl SetDataInWorld
	SetDataInWorld:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		jal GetInScreenOffset
		add $t0, $v0, $s1
		sw $a2, 0($t0)
		
		lw $ra, 0($sp)
    		addi $sp, $sp, 4
    		jr $ra