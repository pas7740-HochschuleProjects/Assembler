# Snake
# $s0: Running
# $s1: World
# $s2: Worm [(x,y)]
# $s3: HeadIndex

.data
	redColor: .word 0xff0000
	blueColor: .word 0x0000ff
	greenColor: .word 0x00ff00
	yellowColor: .word 0xffff00
	worm: .space 256
	world: .space 16384
	worldSize: .word 16384
	headIndex: .space 8
.text
	.globl main
	main:
		# Game
		#jal SetWorld
		jal SetWorm
		li $s0, 1
		jal ShowWorm
		jal GameLoop
		
		jal Exit
        
        Exit:
        	# End Program
		li $v0, 10
             	syscall
             	
        GameLoop:
        	#bgt $s0, 0, Exit
        	lw $t0, 0($s3)
        	bgt $t0, 31, Exit
        	jal MoveWorm
        	jal ShowWorm
        	li $a0, 200
        	jal Sleep
		j GameLoop
		
	SetWorm:
		# Worm First Pos
		la $s2, worm
		sw $zero, 0($s2)
		sw $zero, 4($s2)
		# Worm Head
		la $s3, headIndex
		sw $zero, 0($s3)
		sw $zero, 4($s3)
		jr $ra
	
	SetWorld:
		la $s1, world
		lw $t0, worldSize
		# World is 0
		li $t1, 0
		StartInitWorldLoop:
			bgt $t1, $t0, EndInitWorldLoop
			add $t2, $t1, $s1
			sw $zero, 0($t2)
			addi $t1, $t1, 4
			j StartInitWorldLoop
		EndInitWorldLoop:
			jr $ra
	
	ShowWorm:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		lw $a0, 0($s3)
		lw $a1, 4($s3)
		lw $a2, redColor
		jal Draw
		
		lw $ra, 0($sp)
    		addi $sp, $sp, 4
		jr $ra
		
	MoveWorm:
		# Add one at the x-Axis
		lw $t0, 0($s3)
		addi $t0, $t0, 1
		sw $t0, 0($s3)
		jr $ra
