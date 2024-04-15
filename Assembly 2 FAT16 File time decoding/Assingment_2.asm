TITLE CS2810 Assembler Template

; Student Name: Bradon Barfuss
; Assignment Due Date: 3/24/2024

INCLUDE Irvine32.inc
.data
	;--------- Enter Data Here
	vSemester byte "CS2810 Spring Semester 2024", 0
	vAssignment byte "Assembler Assignment #2", 0
	vName byte "Bradon Barfuss", 0
	vInstructions byte "Please Enter FAT16 file time in hex format: ", 0
	vTimeField byte "--:--:--"

.code
main PROC
	;--------- Enter Code Below Here
	call ClrScr

	mov dh, 7
	mov dl, 20

	call Gotoxy

	mov edx, offset vSemester
	call WriteString

	mov dh, 8
	mov dl, 20

	call Gotoxy

	mov edx, offset vAssignment
	call WriteString


	mov dh, 9
	mov dl, 20

	call Gotoxy

	mov edx, offset vName
	call WriteString

	mov dh, 11
	mov dl, 20

	call Gotoxy

	mov edx, offset vInstructions
	call WriteString

	mov dh, 11
	mov dl, 64

	call gotoxy


	; Get hours
	call readHex
	ror ax, 8 ;read little indian style

	mov ecx, eax ;save the orginal input

	and ax, 1111100000000000b ;get rid of all other bits other than the first 5 (min section)

	SHR ax, 11 ;move the 5 bits to the right

	mov bh, 10 ;used to divide the number we want to divide by 10

	div bh ; divide the ax register value by bh (10)

	add ax, 3030h ; add 30 to both halfs of the register to get it into ascii

	mov word ptr [vTimeField+0], ax


	; get the minutes
	mov eax,ecx

	
	and ax, 0000000000011111b ;get rid of all other bits other than the first 5 (sec section)

	;SHR ax, 5 ;move the 6 bits to the right

	shl ax, 1

	mov bh, 10 ;used to divide the number we want to divide by 10

	div bh ; divide the ax register value by bh (10)

	add ax, 3030h ; add 30 to both halfs of the register to get it into ascii

	mov word ptr [vTimeField+6], ax


	; get the seconds
	mov eax,ecx

	
	and ax, 0000011111100000b ;get rid of all other bits other than the first 5 (hours section)

	SHR ax, 5 ;move the 6 bits to the right

	mov bh, 10 ;used to divide the number we want to divide by 10

	div bh ; divide the ax register value by bh (10)

	add ax, 3030h ; add 30 to both halfs of the register to get it into ascii

	mov word ptr [vTimeField+3], ax




	mov dh, 12
	mov dl, 20

	call gotoxy

	mov edx, offset vtimeField
	call writeString
	call readstring



	exit
main ENDP

END main

