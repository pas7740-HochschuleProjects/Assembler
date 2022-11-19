# Snake
# $s0: Running
# $s1: World
# $s2: Worm [(x,y)]
# $s3: HeadIndex
# $s4: Current Key

.include "io.asm"
.include "basicOperations.asm"

.data
	redColor: .word 0xff0000
	blueColor: .word 0x0000ff
	greenColor: .word 0x00ff00
	yellowColor: .word 0xffff00
	blackColor: .word 0x000000
	
	worm: .space 80
	wormSize: .word 80	# 8* 3 WormParts
	world: .space 16384
	worldSize: .word 16384
.text
	Main:
		# Game
		jal InitWorm
		li $s0, 1
		li $s4, 0
		jal ShowWorm
		jal GameLoop
             	
        GameLoop:
        	beq $s0, 0, EndGameLoop
        	jal ReadInput
        	jal CleanTail
        	jal MoveWorm
        	jal ShowWorm
        	Sleep(100)
		j GameLoop
		EndGameLoop:
			Exit
		
	InitWorm:
		# Worm First Pos
		la $s2, worm
		li $t0, 0
		li $t1, -1
		lw $t2, wormSize
		InitWormLoop:
			add $t3, $t0, $s2
			sw $t1, 0($t3)
			add $t0, $t0, 4
			bne $t0, $t2, InitWormLoop
		# Set First element
		sw $zero, 0($s2)
		sw $zero, 4($s2)
		# Worm Head
		li $s3, 0
		jr $ra
	
	ShowWorm:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		add $a0, $s3, $s2
		add $a1, $a0, 4
		lw $a0, 0($a0)
		lw $a1, 0($a1)
		lw $a2, redColor
		jal Draw
		
		lw $ra, 0($sp)
    		addi $sp, $sp, 4
		jr $ra
		
	MoveWorm:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		# Add one at the x-Axis
		add $t0, $s3, $s2
		add $t1, $t0, 4
		lw $t0, 0($t0)
		lw $t1, 0($t1)
		
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
			move $a0, $t0
			move $a1, $t1
			CallerSave
			jal OutOfBounds
			bne $v0, 1, IncrementHead
			li $s0, 0
			lw $ra, 0($sp)
    			addi $sp, $sp, 4
			jr $ra
			
			IncrementHead:
			CallerRestore
			# Increment of head index
			lw $t3, wormSize
			#add $t3, $t3, -8
			add $t2, $s3, 8	# head index + 1
			
			slt $t3, $t2, $t3
			beq $t3, $zero, SetZeroHeadIndex
			# Else
			move $s3, $t2
			j SaveNewHeadIndex
			
			# Jump over if else
			SetZeroHeadIndex:
				li $s3, 0
			
			SaveNewHeadIndex:
				add $t2, $s3, $s2
				add $t3, $t2, 4
				sw $t0, 0($t2)
				sw $t1, 0($t3)
			
			lw $ra, 0($sp)
    			addi $sp, $sp, 4
			jr $ra
	
	CleanTail:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		add $a0, $s3, 8
		lw $a1, wormSize
		jal mod
		move $t0, $v0	# TailIndex
		
		# Clean Tail
		add $t1, $t0, $s2
		add $t2, $t1, 4
		lw $a0, 0($t1)
		lw $a1, 0($t2)
		lw $a2, blackColor
		jal Draw
		
		lw $ra, 0($sp)
    		addi $sp, $sp, 4
		jr $ra
		
	ReadInput:
		lui $t1, 0xffff
		lw $s4, 4($t1)
		jr $ra
		
.include "display.asm"
.include "math.asm"
