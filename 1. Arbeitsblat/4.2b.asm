.text
	# Printing out the text
    	li $v0, 4
    	la $a0, text
    	syscall
	
	# Read first number
	li $v0, 5		# Syscall "Read Int"
	syscall
	move $t0, $v0		# Save Input in $t0
	
	# Printing out the text
    	li $v0, 4
    	la $a0, text
    	syscall
	
	# Read second number
	li $v0, 5		# Syscall "Read Int"
	syscall
	move $t1, $v0		# Save Input in $t1
	
	# Operations
	mult $t0, $t1		# Mult
	mflo $t2		# Move product to $t2
	add $t3, $t0, $t1	# Add $t0 and $t1 to $t3
	
	# Save
	sw $t2, addr_product	# Save product
	sw $t3, addr_sum	# Save sum
	
.data
	text: .asciiz "Enter a number: "
	addr_product: .word 0
	addr_sum: .word 0
