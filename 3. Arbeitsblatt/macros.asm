.data

.text
	.macro Exit
		li $v0, 10
             	syscall
	.end_macro