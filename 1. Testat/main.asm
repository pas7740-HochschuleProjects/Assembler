.include "io.asm"

.data
	firstInputText: .asciiz "First Word (max. 10 Characters): "
	secondInputText: .asciiz "Second Word (max. 10 Characters): "
	breakText: .asciiz "\n"
	firstInput: .space 11
	secondInput: .space 11
	inputSize: .word 11

.text
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
		addu $a0, $t0, $s0
		addu $a1, $t0, $s1
		lbu $a0, 0($a0)
		lbu $a1, 0($a1)
		# Compare
		bne $a0, $a1, EndComparison
		addi $t0, $t0, 1
		j StartComparison
	EndComparison:
		jal GetSmallerChar
		bnez $v0, PrintSecondInputAtFirst
	
	# Print result and exit program
	PrintFirstInputAtFirst:
		PrintString(firstInput)
		PrintString(breakText)
		PrintString(secondInput)
		Exit
	PrintSecondInputAtFirst:
		PrintString(secondInput)
		PrintString(breakText)
		PrintString(firstInput)
		Exit
	
	# Functions
	
	# Compares two chars and outputs 0 if first and 1 if second char is smaller/ GetSmallerChar(a0:=char, a1:=char) => ret v0
	GetSmallerChar:
		slt $a0, $a0, $a1	# a0 < a1
		beq $a0, 1, FirstIsSmaller
		SecondIsSmaller:
			li $v0, 1
			jr $ra
		FirstIsSmaller:
			li $v0, 0
			jr $ra