TITLE CS2810 Assembler Template

; Student Name: Bradon Barfuss
; Assignment Due Date: 3/24/2024

INCLUDE Irvine32.inc
.data
	;--------- Enter Data Here
	vSemester BYTE "CS2810 Spring Semester 2024", 0
	vAssignment BYTE "Assembler Assignment #5", 0
	vName BYTE "Bradon Barfuss", 0

	vFirstGuessPrompt BYTE "Guess a number between 0 and 100: ", 0
	vGuessAgainPrompt BYTE "Guess again: ", 0
	vCorrectGuessPrompt BYTE " is correct!", 0
	vPlayAgainPrompt BYTE "Would you like to play again? (1 for yes, 0 for no)", 0
	vGuessTooLowPrompt BYTE " is too low", 0
	vGuessTooHighPrompt BYTE " is too high", 0
	vCarriageReturn byte 13,10,0

	;eax, ebx, edx

.code

;eax has the random number, but may change
;ecx has perminate random number
;edx display stuff the screen

main PROC
	call Randomize ;enable random number everytime
	call ProgramLoop

	exit





playAgain:
	call NewLine
	call PromptPlayAgain
	call NewLine
	call GetUserInput
	cmp eax, 1
	jz ProgramLoop

	exit


PromptPlayAgain:
	mov edx, offset vPlayAgainPrompt
	call WriteString
	ret


ProgramLoop:
	call ClrScr
	call DisplaySemester
	call DisplayAssignment
	call DisplayName
	call DisplayFirstPrompt
	call GenerateRandomNumber
	call GuessingLoop


GuessingLoop:
	call GetUserInput
	call CompareGuess


CompareGuess:
	cmp eax, ecx
	jz Correct

	cmp eax, ecx
	jl LessThan

	cmp eax, ecx
	jg GreaterThan

Correct:
	call WriteNumber
	call WriteCorrectAnswer
	call playAgain
	; make function to ask to play again the jump to programloop if yes



LessThan:
	call WriteNumber
	call LessThanAnswer
	call newGuess
	ret

GreaterThan:
	call WriteNumber
	call GreaterThanAnswer
	call newGuess
	ret

newGuess:
	call NewLine 
	call GuessAgainPrompt
	call GuessingLoop



WriteCorrectAnswer:
	mov edx, offset vCorrectGuessPrompt
	call WriteString
	ret

LessThanAnswer:
	mov edx, offset vGuessTooLowPrompt
	call WriteString
	ret

GreaterThanAnswer:
	mov edx, offset vGuessTooHighPrompt
	call WriteString
	ret

GuessAgainPrompt:
	mov edx, offset vGuessAgainPrompt
	call WriteString
	ret



GenerateRandomNumber: ;pick a number between 0 and 100 and move it into ecx for periminate storage
	mov eax, 101
	Call RandomRange
	mov ecx, eax ;move the random number into the ecx register
	ret

GetUserInput: ;get input into the eax register
	call ReadDec ;get user input and put in into the eax register
	ret; return

WriteNumber: ;display the interger in the eax register to the screen
	;mov eax, ecx
	call WriteDec
	ret

Newline:
	mov edx, offset vCarriageReturn
	call WriteString
	ret





DisplaySemester:
	mov dh, 4
	mov dl, 0

	call Gotoxy

	mov edx, offset vSemester
	call WriteString
	ret;

DisplayAssignment:
	mov dh, 5
	mov dl, 0

	call Gotoxy

	mov edx, offset vAssignment
	call WriteString
	ret;

DisplayName:
	mov dh, 6
	mov dl, 0

	call Gotoxy

	mov edx, offset vName
	call WriteString
	ret;

DisplayFirstPrompt:
	mov dh, 8
	mov dl, 0

	call Gotoxy

	mov edx, offset vFirstGuessPrompt
	call WriteString
	ret

	
main ENDP

END main

