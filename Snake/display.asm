.data
	displayAddress:	.word 0x10008000
	displayWidth: .word 512
	displayHeight: .word 512
	unitWidth: .word 16
	unitHeight: .word 16
.text
	# x-Position in $a0, y-Position in $a1, Colour-Code in $a2, void
	Draw:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		lw $t2, displayAddress
		
		jal GetInScreenOffset
		add $t0, $v0, $t2
		sw $a2, 0($t0)
    		
    		lw $ra, 0($sp)
    		addi $sp, $sp, 4
    		jr $ra
    	
    	# x-Position in $a0, y-Position in $a1, return offset in $v0
    	GetInScreenOffset:
    		# Calculate Offset
		lw $t0, displayWidth
		lw $t1, unitWidth
		div $t0, $t0, $t1
		
		sll $a0, $a0, 2
		sll $a1, $a1, 2
		mult $a1, $t0	# y-Offset
		mflo $v0
		add $v0, $v0, $a0
		
    		jr $ra
    		
    	# x-Position in $a0, y-Position in $a1
    	OutOfBounds:
    		lw $t0, displayWidth
		lw $t1, unitWidth
		div $t0, $t0, $t1
		lw $t2, displayHeight
		lw $t3, unitHeight
		div $t2, $t2, $t3
		
		slti $t1, $a0, 0
		slti $t3, $a1, 0
    		bne $t1, 0, True
    		bne $t3, 0, True
    		
    		slt $t1, $a0, $t0
    		slt $t3, $a1, $t2
    		bne $t1, 1, True
    		bne $t3, 1, True
    		
    		# Else False
    		False:
    			li $v0, 0
    			jr $ra
    		True:
    			li $v0, 1
    			jr $ra
