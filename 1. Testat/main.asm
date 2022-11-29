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
		addu $t1, $t0, $s0
		addu $t2, $t0, $s1
		lbu $t1, 0($t1)
		lbu $t2, 0($t2)
		# Compare
		bne $t1, $t2, EndComparison
		addi $t0, $t0, 1
		j StartComparison
	EndComparison:
		# Push stack
		add $sp, $sp, -8
		sw $t1, 0($sp)
		sw $t2, 4($sp)
		
		IsFirstCharUpper:
			lw $a0, 0($sp)
			jal IsCapitalLetter
			bne $v0, 2, IsSecondCharUpper
			jal SetCharLower
			sw $v0, 0($sp)
		
		IsSecondCharUpper:
			lw $a0, 4($sp)
			jal IsCapitalLetter
			bne $v0, 2, CheckLowerOrGreater
			jal SetCharLower
			sw $v0, 4($sp)
			
		# Pop stack
		lw $t1, 0($sp)
		lw $t2, 4($sp)
		add $sp, $sp, 8
		
		CheckLowerOrGreater:
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
		
	# Functions
	
	# If result is 2, char is uppercase / IsCapitalLetter(a0)=>v0
	IsCapitalLetter:
		sgeu $t1, $a0, 'A'	# If char is between A and Z
		sleu $t2, $a0, 'Z'
		add $v0, $t1, $t2
		jr $ra
	
	# Returns lower char / SetCharLower(a0)=>v0
	SetCharLower:
		addi $v0, $a0, 32
		jr $ra
