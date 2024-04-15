TITLE CS2810 Assembler Template

; Student Name: Bradon Barfuss
; Assignment Due Date: 3/24/2024

INCLUDE Irvine32.inc
.data
	;--------- Enter Data Here
	vSemester byte "CS2810 Spring Semester 2024", 0
	vAssignment byte "Assembler Assignment #3", 0
	vName byte "Bradon Barfuss", 0
	vUserPrompt byte "Please Enter MP3 frame Header in hex format: ", 0

	vMpeg25 BYTE "MPEG Version 2.5", 0
	vMpeg20 BYTE "MPEG Version 2.0", 0
	vMpeg10 BYTE "MPEG Version 1.0", 0
	vMpegRE BYTE "MPEG Reserved", 0
	vLayer1 BYTE "Layer I", 0
	vLayer2 BYTE "Layer II", 0
	vLayer3 BYTE "Layer III", 0
	vLayerRE BYTE "Layer Reserved", 0

	vBit0MPEG1 BYTE "44100 Hz", 0
	vBit0MPEG2 BYTE "22050 Hz", 0
	vBit0MPEG25 BYTE "11025 Hz", 0
	
	vBit1MPEG1 BYTE "48000 Hz", 0
	vBit1MPEG2 BYTE "24000 Hz", 0
	vBit1MPEG25 BYTE "12000 Hz", 0

	vBit2MPEG1 BYTE "32000 Hz", 0
	vBit2MPEG2 BYTE "16000 Hz", 0
	vBit2MPEG25 BYTE "8000 Hz", 0
	vreserved BYTE "Reserved Sample", 0


.code
main PROC
	
	call ClrScr
	call DisplaySemester
	call DisplayAssignment
	call DisplayName
	call DisplayUserPrompt
	call DisplayVersion
	call DisplayLayer
	call DisplaySamplingRate

exit




GetUserInput:
	mov dh, 16
	mov dl, 57

	call gotoxy

	call readHex
	
	mov ecx, eax ;save the orginal input
	ret;


DisplayVersion:
	call GetUserInput

	;mov eax, 0FFFB9264h
			;AAAAAAAAAAABBCCDEEEEFFGHIIJJKLMM
	mov eax, ecx
	and eax, 00000000000110000000000000000000b
	shr eax, 19

	
	mov dh, 17
	mov dl, 12
	call Gotoxy

	cmp eax, 00b
	jz dMpeg25 ;call display dMpeg25 version

	cmp eax, 01b
	jz dMpegRE

	cmp eax, 10b
	jz dMpeg20


	mov edx, offset vMpeg10
	mov ebx, 11b
	jmp DisplayString

dMpeg25:
	mov edx, offset vMpeg25
	mov ebx, 00b
	jmp DisplayString

dMpegRE:
	mov edx, offset vMpegRE
	mov ebx, 01b
	jmp DisplayString


dMpeg20:
	mov edx, offset vMpeg20
	mov ebx, 10b
	jmp DisplayString

DisplayString:
	call WriteString


	ret;return display version






DisplayLayer:
	;mov eax, 0FFFB9264h
			; AAAAAAAAAAABBCCDEEEEFFGHIIJJKLMM
	mov eax, ecx
	and eax,  00000000000001100000000000000000b
	shr eax, 17

	
	mov dh, 18
	mov dl, 12
	call Gotoxy


	cmp eax, 00b
	jz DisplayLayerReserved

	cmp eax, 01b
	jz DisplayLayer3

	cmp eax, 10b
	jz DisplayLayer2

	mov edx, offset vLayer1
	jmp DisplayString3

DisplayLayerReserved:
	mov edx, offset vLayerRE
	jmp DisplayString3

DisplayLayer2:
	mov edx, offset vLayer2
	jmp DisplayString3

DisplayLayer3:
	mov edx, offset vLayer3
	jmp DisplayString3

	ret ; return display layer


DisplayString3:
	call WriteString




DisplaySamplingRate:
	mov eax, ecx
	and eax, 00000000000000000000110000000000b
	shr eax, 10

	
	mov dh, 19
	mov dl, 12
	call Gotoxy

	
	cmp eax, 00b
	jz SampleRateBit0

	cmp eax, 01b
	jz SampleRateBit1

	cmp eax, 10b
	jz SampleRateBit2

	mov edx, offset vreserved
	jmp DisplayString2



SampleRateBit0:
	cmp ebx, 11b
	jz SampleRateBit0MPEG1

	cmp ebx, 10b
	jz SampleRateBit0MPEG2

	cmp ebx, 00b
	jz SampleRateBit0MPEG25


SampleRateBit1:
	cmp ebx, 11b
	jz SampleRateBit1MPEG1

	cmp ebx, 10b
	jz SampleRateBit1MPEG2

	cmp ebx, 00b
	jz SampleRateBit1MPEG25

SampleRateBit2:
	cmp ebx, 11b
	jz SampleRateBit2MPEG1

	cmp ebx, 10b
	jz SampleRateBit2MPEG2

	cmp ebx, 00b
	jz SampleRateBit2MPEG25


SampleRateBit0MPEG1:
	mov edx, offset vBit0MPEG1
	jmp DisplayString2

SampleRateBit0MPEG2:
	mov edx, offset vBit0MPEG2
	jmp DisplayString2

SampleRateBit0MPEG25:
	mov edx, offset vBit0MPEG25
	jmp DisplayString2

SampleRateBit1MPEG1:
	mov edx, offset vBit1MPEG1
	jmp DisplayString2

SampleRateBit1MPEG2:
	mov edx, offset vBit1MPEG2
	jmp DisplayString2

SampleRateBit1MPEG25:
	mov edx, offset vBit1MPEG25
	jmp DisplayString2

SampleRateBit2MPEG1:
	mov edx, offset vBit2MPEG1
	jmp DisplayString2

SampleRateBit2MPEG2:
	mov edx, offset vBit2MPEG2
	jmp DisplayString2

SampleRateBit2MPEG25:
	mov edx, offset vBit2MPEG25
	jmp DisplayString2



DisplayString2:
	call WriteString
	
	ret





DisplaySemester:
	mov dh, 12
	mov dl, 12

	call Gotoxy

	mov edx, offset vSemester
	call WriteString
	ret;

DisplayAssignment:
	mov dh, 13
	mov dl, 12

	call Gotoxy

	mov edx, offset vAssignment
	call WriteString
	ret;

DisplayName:
	mov dh, 14
	mov dl, 12

	call Gotoxy

	mov edx, offset vName
	call WriteString
	ret;

DisplayUserPrompt:
	mov dh, 16
	mov dl, 12

	call Gotoxy

	mov edx, offset vUserPrompt
	call WriteString
	ret;


main ENDP

END main

