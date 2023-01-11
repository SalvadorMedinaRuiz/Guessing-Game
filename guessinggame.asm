		.ORIG			x3000

;;Loads and siaplys the prompt for the number to guessed
		LEA			R0, PROMPT1
		PUTS		
		GETC
		OUT

;;Time to convert the character number to an actual number
		ST			R0, FIRSTNUM					
		LD			R1, CONVERTTONUM
		LD			R0, FIRSTNUM
		ADD			R0, R0, R1
		ST			R0, FIRSTNUM					;Stores the number to be guessed in FIRSTNUM

;;Loads and displays the prompt for the number that is guessed
		LEA			R0, PROMPT2					
		PUTS
LOOP		GETC
		OUT

;;Time to convert the guess number to an actual number
		ST			R0, GUESSNUM					
		LD			R1, CONVERTTONUM
		LD			R0, GUESSNUM
		ADD			R0, R0, R1
		ST			R0, GUESSNUM					;stores the guessed number in GUESSNUM

;;TIme to convert the guessed number to the negative
		
		LD			R1, GUESSNUM
		NOT			R1, R1
		ADD			R1, R1, #1					
		ST			R1, GUESSNUM					;2's compliment of the guessed number and puts it into GUESSNUM

;;Time for the actual program
		AND			R0, R0, 0
		LD			R1, FIRSTNUM
		LD			R2, GUESSNUM
		ADD			R0, R1, R2					;So, for example, R0= 5 -3 so R0=2. 3<5, so +2 means its too small. if -2, (5-7), then too big. 
		BRP			TOOSMALL
		BRN			TOOBIG
		BRZ			CORRECT
		
		
;;Too small?

TOOSMALL	LEA			R0, SMALLPROMPT
		PUTS
		ADD			R3, R3, #1					;Adds 1 to R3 (the checker to see if we exceed 10 tries)
		ADD			R4, R3, #-10
		BRZ			DONE
		BR			LOOP
;;Too big?

TOOBIG		LEA			R0, BIGPROMPT
		PUTS
		ADD			R3, R3, #1					;Adds 1 to R3 (the checker to see if we exceed 10 tries)
		ADD			R4, R3, #-10
		BRZ			DONE
		BR			LOOP
;;Correct!
CORRECT		ADD			R3, R3, #1
		LEA			R0, CORRECTPROMPT
		PUTS
		LD			R1, CONVERTTONUM2
		ADD			R3, R3, R1 					;convert amount of tries to actual character
		ST			R3, TRIESAMOUNT					;stores that character in a blkw space
		LEA			R0, TRIESAMOUNT
		PUTS
		BR			DONE2
		
;;Player 2 lost (Too many tries)
DONE		LEA			R0, DONEPROMPT
		PUTS
		BR			DONE2


DONE2		HALT
PROMPT1		.STRINGZ		"Enter a number to be guessed: "
PROMPT2		.STRINGZ		"\nGuess the number: "	
FIRSTNUM	.BLKW			2
GUESSNUM	.BLKW			2
SMALLPROMPT	.STRINGZ		"\nToo small! Try again!: "
BIGPROMPT	.STRINGZ		"\nToo big! Try again!: "
CORRECTPROMPT	.STRINGZ		"\nYou are correct! The amount of tries you took were: "	
DONEPROMPT	.STRINGZ		"\nGame over. Player 1 wins."
TRIESAMOUNT	.BLKW			2
CONVERTTONUM	.FILL			-48
CONVERTTONUM2	.FILL			48
		.END