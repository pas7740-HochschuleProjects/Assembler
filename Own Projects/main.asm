# Snake
# $s0: Running
# $s1: World
# $s2: Worm [(x,y)]
# $s3: HeadIndex
# $s4: Current Key

# Enum Definitions


.include "io.asm"
.include "basicOperations.asm"

.data
	redColor: .word 0xff0000
	blueColor: .word 0x0000ff
	greenColor: .word 0x00ff00
	yellowColor: .word 0xffff00
	
	worm: .space 256
	wormSize: .word 256
	world: .space 16384
	worldSize: .word 16384
	
	headIndex: .space 8
.text
	Main:
		# Game
		#jal SetWorld
		jal SetWorm
		li $s0, 1
		li $s4, 0
		jal ShowWorm
		jal GameLoop
             	
        GameLoop:
        	beq $s0, 0, EndGameLoop
        	jal ReadInput
        	Sleep(100)
        	jal MoveWorm
        	jal ShowWorm
		j GameLoop
		EndGameLoop:
			Exit
		
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
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		# Add one at the x-Axis
		lw $t0, 0($s3)
		lw $t1, 4($s3)
		
		beq $s4, 0, MoveRight
		beq $s4, 97, MoveLeft
		beq $s4, 100, MoveRight
		beq $s4, 115, MoveDown
		beq $s4, 119, MoveUp
		MoveLeft:
			addi $t0, $t0, -1
			j EndMoveWorm
		MoveRight:
			addi $t0, $t0, 1
			j EndMoveWorm
		MoveDown:
			addi $t1, $t1, 1
			j EndMoveWorm
		MoveUp:
			addi $t1, $t1, -1
			j EndMoveWorm
		EndMoveWorm:
			# If worm out of bounds
			lw $a0, 0($s3)
			lw $a1, 4($s3)
			CallerSave
			jal OutOfBounds
			beq $v0, 1, EndRunning
			CallerRestore
			
			sw $t0, 0($s3)
			sw $t1, 4($s3)
			
			lw $ra, 0($sp)
    			addi $sp, $sp, 4
			jr $ra
		
	ReadInput:
		lui $t1, 0xffff
		lw $s4, 4($t1)
		jr $ra
		
	EndRunning:
		li $s0, 0
		jr $ra
		
.include "display.asm"
