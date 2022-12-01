.data
	firstInputText: .asciiz "First Word (max. 10 Characters): "
	secondInputText: .asciiz "Second Word (max. 10 Characters): "
	breakText: .asciiz "\n"
	resultText: .asciiz "Result: "
	firstInput: .space 11
	secondInput: .space 11
	inputSize: .word 11

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

	#--------------------------------------
	#------------ Start Program -----------
	#--------------------------------------

	# Print Text and Read Input
	PrintString(firstInputText)
	ReadStringInput(firstInput, inputSize)
	PrintString(breakText)
	PrintString(secondInputText)
	ReadStringInput(secondInput, inputSize)
	PrintString(breakText)
	
	# Load
	li $t0, 0	# loop index
	la $s0, firstInput
	la $s1, secondInput
	
	# Compare inputs
	StartComparison:
		# Get chars
		addu $t1, $t0, $s0
		addu $t2, $t0, $s1
		lbu $t1, 0($t1)
		lbu $t2, 0($t2)
		# Compare
		bne $t1, $t2, EndComparison
		addi $t0, $t0, 1
		j StartComparison
	EndComparison:
		slt $t3, $t1, $t2	# t1 < t2
		bne $t3, 1, PrintSecondInput
	
	# Print result and exit program
	PrintFirstInput:
		PrintString(resultText)
		PrintString(firstInput)
		Exit
	PrintSecondInput:
		PrintString(resultText)
		PrintString(secondInput)
		Exit
