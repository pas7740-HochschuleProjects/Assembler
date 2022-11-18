.data
	displayAddress:	.word 0x10008000
	redColor: .word 0xff0000
	blueColor: .word 0x0000ff
	greenColor: .word 0x00ff00
	yellowColor: .word 0xffff00
.text
	.globl main
	main:
		# Set
		lw $a0, displayAddress
		li $a1, 5
		li $a2, 1
		lw $a3, blueColor
		jal Draw
		
		# Call Exit
		jal Exit
        
        .globl Exit
        Exit:
        	# End Program
		li $v0, 10
             	syscall
