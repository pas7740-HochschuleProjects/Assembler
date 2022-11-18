.text
	# Print Func needs string in $a0
	.globl Print
	Print:
		li $v0, 4
    		syscall
    		jr $ra
