.data
	text: .asciiz "Hello World"
.text
	jal Main
	
	.globl Main
	Main:
		# Call Print
		la $a0, text
		jal PrintAtPosition
		
		# Call Exit
		jal Exit
        
        .globl Exit
        Exit:
        	# End Program
		li $v0, 10
             	syscall