.data
.text
	.macro SetFood(%x, %y)
    		li $a0, %x
    		li $a1, %y
    		li $a2, 1
    		jal SetDataInWorld
    		
    		li $a0, %x
    		li $a1, %y
    		lw $a2, yellowColor
    		jal Draw
    	.end_macro

	.globl InitWorld
	InitWorld:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
	
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
		
		# Set Food
		SetFood(10,1)
		SetFood(5,3)
		SetFood(20,2)
		SetFood(30,2)
		SetFood(5,30)
		SetFood(14,17)
		SetFood(16,24)
		
		lw $ra, 0($sp)
    		addi $sp, $sp, 4
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
    		
    	# x-Position in $a0, y-Position in $a1
	.globl GetDataInWorld
	GetDataInWorld:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		jal GetInScreenOffset
		add $v0, $v0, $s1
		lw $v0, 0($v0)
		
		lw $ra, 0($sp)
    		addi $sp, $sp, 4
    		jr $ra
    		
    		