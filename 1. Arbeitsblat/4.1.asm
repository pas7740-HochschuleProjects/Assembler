.text
	lw $t0, addr_a		# Load A
	lw $t1, addr_c		# Load C
	lw $t2, addr_b		# Load B
	addi $t1, $t0, 0	# Add 0 to A
	sll $t2, $t2, 1		# Shift/Mult with 2 B
	add $t1, $t1, $t2	# Add A to C
	sw $t1, addr_c		# Save C
	sw $t0, addr_a		# Save A
	sw $t2, addr_b		# Save B

.data
addr_a: .word 10
addr_b: .word 1
addr_c: .word 0
