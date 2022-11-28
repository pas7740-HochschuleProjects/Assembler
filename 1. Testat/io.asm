.text
	# Prints string in console / %string needs address
    	.macro PrintString (%string)
    		la $a0, %string
    		li $v0, 4	# Syscall "Print string"
    		syscall
    	.end_macro
    	
    	# Reads console input as string / %buffer needs an address, %size needs a word
    	.macro ReadStringInput (%buffer, %size)
		la $a0, %buffer
		lw $a1, %size
		li $v0, 8	# Syscall "Read string"
		syscall
	.end_macro
	
	# Exit Program
	.macro Exit
		li $v0, 10
             	syscall
        .end_macro