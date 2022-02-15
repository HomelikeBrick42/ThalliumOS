; bx - string to print
PrintString:
	pusha
	mov ah, 0x0e
	.StartLoop:
	mov al, byte [bx]
	cmp al, 0
	je .EndLoop
		push bx
		xor bx, bx
		int 0x10
		pop bx
		inc bx
	jmp .StartLoop
	.EndLoop:
	popa
	ret
