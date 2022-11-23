.text
	li $t0, 5		# Save const 5
	li $t1, 10		# Save const 10
	mult $t0, $t1		# Mult 10 and 5
	mflo $t2		# Set Product in $t2
	sw $t2, addr_sum	# Save $t2 in addr_sum

.data
addr_sum: .word 0
