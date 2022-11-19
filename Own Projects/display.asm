.data
	displayAddress:	.word 0x10008000
	displayWidth: .word 512
	displayHeight: .word 512
	unitWidth: .word 16
	unitHeight: .word 16

.text
	# x-Position in $a0, y-Position in $a1, Colour-Code in $a2, void
	.globl Draw
	Draw:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		lw $t2, displayAddress
		
		jal GetOffset
		add $t0, $v0, $t2
		sw $a2, 0($t0)
    		
    		lw $ra, 0($sp)
    		addi $sp, $sp, 4
    		jr $ra
    	
    	# x-Position in $a0, y-Position in $a1, return offset in $v0
    	GetOffset:
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
    	.globl OutOfBounds
    	OutOfBounds:
    		lw $t0, displayWidth
		lw $t1, unitWidth
		div $t0, $t0, $t1
		add $t0, $t0, -1
		lw $t2, displayHeight
		lw $t3, unitHeight
		div $t2, $t2, $t3
		add $t2, $t2, -1
		
    		beq $a0, -1, True
    		beq $a1, -1, True
    		beq $a0, $t0, True
    		beq $a1, $t2, True
    		
    		# Else False
    		False:
    			li $v0, 0
    			jr $ra
    		True:
    			li $v0, 1
    			jr $ra
