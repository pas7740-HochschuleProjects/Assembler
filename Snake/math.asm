.data

.text
	# number $a0, divider $a1, $v0 result
	mod:
		div $a0, $a1
		mfhi $v0
		jr  $ra