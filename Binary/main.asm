.data
	x: .word 1
.text
	lw $t0, x
	add $t0, $t0, 1
	sw $t0, x