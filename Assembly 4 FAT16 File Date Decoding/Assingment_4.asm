TITLE CS2810 Assembler Template

; Student Name: Bradon Barfuss
; Assignment Due Date: 3/24/2024

INCLUDE Irvine32.inc
.data
	;--------- Enter Data Here
	vSemester byte "CS2810 Spring Semester 2024", 0
	vAssignment byte "Assembler Assignment #4", 0
	vName byte "Bradon Barfuss", 0
	vUserPrompt byte "Please Enter FAT16 file date: ", 0
	vFinalDate BYTE "             ",0
	vMonthArray BYTE "January ",0,"    "
				BYTE "Febuary ",0,"    "
				BYTE "March ",0,"      "
				BYTE "April ",0,"      "
				BYTE "May ",0,"        "
				BYTE "June ",0,"       "
				BYTE "July ",0,"       "
				BYTE "August ",0,"     "
				BYTE "September ",0,"  "
				BYTE "October ",0,"    "
				BYTE "Novemember ",0," "
				BYTE "Decemeber ",0,"  "


	vTh BYTE "th, ",0
	vSt BYTE "st, ",0
	vNd BYTE "nd, ",0
	vRd BYTE "rd, ",0

	vday BYTE "1", 0," "
	       BYTE "2", 0," "
	       BYTE "3", 0," "
	       BYTE "4", 0," "
		   BYTE "5", 0," "
	       BYTE "6", 0," "
	       BYTE "7", 0," "
		   BYTE "8", 0," "
	       BYTE "9", 0," "
	       BYTE "10", 0
		   BYTE "11", 0
	       BYTE "12", 0
	       BYTE "13", 0
		   BYTE "14", 0
		   BYTE "15", 0
	       BYTE "16", 0
	       BYTE "17", 0
		   BYTE "18", 0
		   BYTE "19", 0
	       BYTE "20", 0
	       BYTE "20", 0
		   BYTE "21", 0
	       BYTE "22", 0
	       BYTE "23", 0
		   BYTE "24", 0
		   BYTE "25", 0
	       BYTE "26", 0
	       BYTE "27", 0
		   BYTE "28", 0
		   BYTE "29", 0
	       BYTE "30", 0
		   BYTE "31", 0

	
	vYear BYTE "####", 0

	;Orginal Input 4423
	;Little Indian 2344
	;2344
	;0010 0011 0100 0100
	;0010001 1010 00100
	;0000000 0000 00000
	; YEAR  MONTH  DAY

.code
main PROC
	
	call ClrScr
	call DisplaySemester
	call DisplayAssignment
	call DisplayName
	call DisplayUserPrompt
	call GetUserInput
	call OutputPosition
	call IsolateMonth
	call WriteMonth
	call IsolateDay
	call writeday
	call AddPrefix
	call IsolateYear
	call AddYearOffset
	call GetYear
	exit



OutputPosition:
	mov dh, 10
	mov dl, 33
	call gotoxy
	ret


IsolateYear:
	mov eax, ecx
	and ax, 1111111000000000b
	shr ax, 9
	ret


AddYearOffset:
	add ax, 11110111100b
	ret

GetYear:
	xor dx, dx ;clear out dx the divisor is dx + ax, we only need dx
	mov bx, 1000 ;move 1000 into the reg that we will divide by (divide by 1000)
	div bx
	add al, 30h
	mov byte ptr [vYear], al
	mov ax, dx
	xor dx, dx
	mov bx, 100
	div bx
	add al, 30h
	mov byte ptr [vYear+1], al
	mov ax, dx
	mov bl, 10
	div bl
	add ax, 3030h
	mov word ptr [vYear+2], ax
	mov edx, offset [vYear]
	call WriteString
	ret;

IsolateDay:
	mov eax, ecx
	and ax, 0000000000011111b
	ret

writeday:
	sub eax, 1
	mov edx, offset[vDay]
	mov bl, 3
	mul bl
	add edx, eax
	call WriteString
	ret


AddPrefix:
	cmp eax, 1
	jz dSt
	cmp eax, 2
	jz dNd
	cmp eax, 3
	jz dRd
	cmp eax, 21
	jz dSt
	cmp eax, 22
	jz dNd
	cmp eax, 23
	jz dRd
	cmp eax, 31
	jz dSt
	
	mov edx, offset [vTh]
	jmp Display

dSt:
	mov edx, offset [vSt]
	jmp Display

dNd:
	mov edx, offset [vNd]
	jmp Display

dRd:
	mov edx, offset [vRd]
	jmp Display

Display:
	call WriteString
	ret;


IsolateMonth:
	mov eax, ecx
	and ax, 0000000111100000b
	shr ax, 5
	ret;

WriteMonth: ;run this after isolatemonth, month from the fat 16 file needs to be in the eax register
	sub eax, 1
	mov edx, offset[vMonthArray]
	mov bl, 13
	mul bl
	add edx, eax
	call WriteString
	ret




GetUserInput:
	mov dh, 8
	mov dl, 63
	call gotoxy

	call readHex ;get user input
	ror ax, 8 ;read little indian style
	mov ecx, eax ;save the orginal input into the ecx register
	ret; return

DisplaySemester:
	mov dh, 4
	mov dl, 33

	call Gotoxy

	mov edx, offset vSemester
	call WriteString
	ret;

DisplayAssignment:
	mov dh, 5
	mov dl, 33

	call Gotoxy

	mov edx, offset vAssignment
	call WriteString
	ret;

DisplayName:
	mov dh, 6
	mov dl, 33

	call Gotoxy

	mov edx, offset vName
	call WriteString
	ret;

DisplayUserPrompt:
	mov dh, 8
	mov dl, 33

	call Gotoxy

	mov edx, offset vUserPrompt
	call WriteString
	ret;

	
main ENDP

END main

