.data
.text
    	# Print Func needs charArray address
    	.macro Print (%string)
    		la $a0, %string
    		li $v0, 4
    		syscall
    	.end_macro
    	
    	# Print Func needs int address
    	.macro PrintInt (%int)
    		move $a0, %int
    		li $v0, 1
    		syscall
    	.end_macro
