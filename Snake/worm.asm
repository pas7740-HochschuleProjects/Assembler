.data
.text
	.globl InitWorm
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
		
	.globl ShowWorm
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
		
	.globl MoveWorm
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
			beq $v0, 1, EndProgram
			CallerRestore
			# If there is worm part
			CallerSave
			jal GetDataInWorld
			beq $v0, 0, EndProgram
			beq $v0, 1, AddOneToScore
			j IncrementHead
			
			# Worm Error
			EndProgram:
				li $s0, 0
				lw $ra, 0($sp)
    				addi $sp, $sp, 4
				jr $ra
			
			AddOneToScore:
				add $s5, $s5, 1
				Print(scoreText)
				PrintInt($s5)
				Print(breakText)
			
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
				
				move $t0, $a0
				move $t1, $a1
				li $a2, 0
				jal SetDataInWorld
			
			lw $ra, 0($sp)
    			addi $sp, $sp, 4
			jr $ra
			
	.globl CleanTail
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
		CallerSave
		jal Draw
		CallerRestore
		li $a2, -1
		jal SetDataInWorld
		
		lw $ra, 0($sp)
    		addi $sp, $sp, 4
		jr $ra
