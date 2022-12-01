.include "io.asm"

# Berechnung:
# A < b

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
		bne $t3, 1, PrintSecondInputAtFirst
	
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
