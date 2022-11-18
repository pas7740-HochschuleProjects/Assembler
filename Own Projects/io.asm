.text
	# Print Func needs string in $a0
	.globl Print
	Print:
		li $v0, 4
    		syscall
    	# PrintAtPoistion Func needs string in $a0, x-Position in $a1, y-Position in $a2
	.globl PrintAtPosition
	PrintAtPosition:
		# Call Loop
		addiu $sp, $sp, -4	# Push on stack
		sw $ra, 0($sp)
		jal Loop
		lw $ra, 0($sp)		# Pop from stack
		addiu $sp, $sp, 4
		
		li $v0, 4
    		syscall
