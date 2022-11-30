.include "macros.asm"

.data
	a: .word -10
	b: .word 20
	c: .word 0
.text
	main:
		lw $s0, a
		
		move $a0, $s0
		lw $a1, b
		jal g
		sw $v0, c
		
		move $a0, $v0
		move $a1, $s0
		jal g
		sw $v0, c
		
		Exit
		
	# Functions
	
	# f(a0,a1)=>v0 / Addition
	f:
		add $v0, $a0, $a1
		jr $ra
	
	# g(a0,a1)=>v0 / Uses t0 and t1
	g:
		# Push
		add $sp, $sp, -16
		sw $ra, 0($sp)		# Save return register
		sw $zero, 4($sp)	# Save t
		sw $zero, 8($sp)	# Save result
		sw $a0, 12($sp)		# Save first parameter
		
		# If
		bgez $a0, If
		Else:
			neg $t0, $a0
			sw $t0, 4($sp)
			j IfEnd
		If:
			sw $a0, 4($sp)
		IfEnd:
		
		# Call f
		lw $a0, 4($sp)
		jal f
		sw $v0, 4($sp)
		
		# Return result (use v0 as t)
		lw $t0, 12($sp)
		add $t1, $t0, $v0
		sw $t1, 8($sp)
		move $v0, $t1
		
		# Pop
		lw $ra, 0($sp)
		add $sp, $sp, 16
		
		jr $ra
		