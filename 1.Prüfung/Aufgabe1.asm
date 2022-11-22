.data
	arr_1: .word 20, 30, 40, 50, 60, 70, 80, 90, 100
	adr_a: .space 4
	adr_i: .word 3
	
.text
	# a)
	la $t0, arr_1		# Load array
	lw $t1, 12($t0)		# Set third item of array in $t1
	sw $t1, adr_a		# Save $t1 in a
	
	# b)
	lw $t1, adr_i		# Load i in $t1 because in $t0 is the array
	sll $t1, $t1, 2		# Get mult i*4 (Shift left) and set the product in $t1
	add $t1, $t1, $t0	# Add $t1 to array base address and save it in $t1
	lw $t2, 0($t1)		# Get item in $t2
	add $t2, $t2, 1		# Add one to the item
	sw $t2, 0($t1)		# Save changed item to the array at position i
	
