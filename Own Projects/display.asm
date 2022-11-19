.data
	displayAddress:	.word 0x10008000
	displayWidth: .word 512
	displayHeight: .word 512
	unitWidth: .word 16
	unitHeight: .word 16

.text
	# x-Position in $a0, y-Position in $a1, Colour-Code in $a2
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