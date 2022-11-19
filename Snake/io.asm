.text
    	# Print Func needs charArray address
    	.macro Print (%string)
    		la $a0, %string
    		li $v0, 4
    		syscall
    	.end_macro
