bits 32

Bootloader32:
	mov eax, Message
	call PrintString
	call Newline
	jmp $

Message:
	db "This is a message", 0
