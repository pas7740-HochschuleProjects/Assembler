.data
	adr_a: .word 10
	adr_b: .word 2
	adr_c: .space 4
	adr_f: .space 4
	adr_g: .word 3
	adr_h: .word 3

.text
	# Needs int
    	.macro PrintInt (%int)
    		move $a0, %int
    		li $v0, 1
    		syscall
    	.end_macro

	sw $zero, adr_c # Save 0 in adr_c
	lw $s0, adr_c #	Load c in $s0
	lw $s1, adr_a # Load a in $s1
	lw $s2, adr_b # Load b in $s2
	la $s3, adr_f # Load f in $s3
	lw $s4, adr_g # Load g in $s4
	lw $s5, adr_h # Load h in $s5
	
	StartWhileLoop:
		sgt $t0, $s1, 0	# Check if a > 0, set $t0 to 1 if true else 0
		beq $t0, 0, EndOfWhileLoop	# Jump to End when $t0 is 0
		sub $s1, $s1, $s2	# a-b
		sw $s1, adr_a	# Save a-b in a
		add $s0, $s0, 1 # c++
		sw $s0, adr_c	# Save c
		j StartWhileLoop	# Jump back
	EndOfWhileLoop:
	
	beq $s0, 5, If	# If c == 5 go to if
	Else:
		sub $s3, $s4, $s5 # g-h in f
		sw $s3, adr_f # Save f
		j EndIf
	If:
		add $s3, $s4, $s5 # g+h in f
		sw $s3, adr_f # Save f
	EndIf:
	
		PrintInt($s3)
	
	