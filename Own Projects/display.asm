.data
	displayWidth: .word 512
	displayHeight: .word 256
	unitWidth: .word 16
	unitHeight: .word 16

.text
	# DisplayAddress in $a0, x-Position in $a1, y-Position in $a2, Colour-Code in $a3
	.globl Draw
	Draw:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		
		jal GetOffset
		add $t0, $v0, $a0
		sw $a3, 0($t0)
    		
    		lw $ra, 0($sp)
    		addi $sp, $sp, 4
    		jr $ra
    		
    	GetOffset:
    		# Calculate Offset
		lw $t0, displayWidth
		lw $t1, unitWidth
		div $t0, $t0, $t1
		
		sll $a1, $a1, 2
		sll $a2, $a2, 2
		mult $a2, $t0	# y-Offset
		mflo $v0
		add $v0, $v0, $a1
		
    		jr $ra