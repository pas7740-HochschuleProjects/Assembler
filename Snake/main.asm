# Snake
# $s0: Running
# $s1: World
# $s2: Worm [(x,y)] # Meanings, -1: Empty, 0: Worm, 1: Food
# $s3: HeadIndex
# $s4: Current InputKey
# $s5: Score

.include "io.asm"
.include "basicOperations.asm"

.data
	redColor: .word 0xff0000
	blueColor: .word 0x0000ff
	greenColor: .word 0x00ff00
	yellowColor: .word 0xffff00
	blackColor: .word 0x000000
	
	worm: .space 80
	wormSize: .word 80	# 8* 10 WormParts
	
	world: .space 4096
	worldSize: .word 4096	# 32*32*4 Pixel
	
	scoreText: .asciiz "Score: "
	breakText: .asciiz "\n"
.text
	Main:
		# Game
		jal InitWorld
		jal InitWorm
		li $s0, 1
		li $s4, 0
		jal ShowWorm
		jal GameLoop
             	
        GameLoop:
        	beq $s0, 0, EndGameLoop
        	jal ReadInput
        	Sleep(100)
        	jal CleanTail
        	jal MoveWorm
        	beq $s0, 0, EndGameLoop
        	jal ShowWorm
		j GameLoop
		EndGameLoop:
			Exit
		
	ReadInput:
		lui $t1, 0xffff
		lw $s4, 4($t1)
		jr $ra
		
.include "display.asm"
.include "math.asm"
.include "worm.asm"
.include "world.asm"
