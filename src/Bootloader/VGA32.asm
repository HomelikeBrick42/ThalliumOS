bits 32

VGA.Width equ 80
VGA.Height equ 25

ClearScreen:
	push eax
	mov eax, 0
	.loop_start:
	cmp eax, VGA.Width*VGA.Height
	je .loop_end
		mov [0xb8000+eax*2], byte ' '
		inc eax
	jmp .loop_start
	.loop_end:
	pop eax
	ret

; ax curosr index
GetCursorIndex:
	push dx
	push bx

	mov ax, 0

	; read location
	mov dx, 0x3D4
	mov al, 0x0F
	out dx, al

	mov dx, 0x3D5
	in al, dx
	push ax

	mov dx, 0x3D4
	mov al, 0x0E
	out dx, al

	mov dx, 0x3D5
	in al, dx
	mov ah, al
	pop bx
	or ax, bx

	pop bx
	pop dx
	ret

; ax - Index to convert
; ax - Output cursor X
; bx - Output cursor Y
CursorIndexToPos:
	push dx
	mov dx, 0
	mov bx, VGA.Width
	div bx
	mov bx, ax
	mov ax, dx
	pop dx
	ret

; ax - Cursor X
; bx - Cursor Y
; ax - Output index
CursorPosToIndex:
	push bx

	push ax
	mov ax, VGA.Width
	mul bx
	mov bx, ax
	pop ax
	add ax, bx

	pop bx
	ret

; ax - Output cursor X
; bx - Output cursor Y
GetCursorPos:
	call GetCursorIndex
	call CursorIndexToPos
	ret

; ax - Cursor X
; bx - Cursor Y
SetCursorPos:
	push ax
	push bx
	push dx

	call CursorPosToIndex
	mov bx, ax
	cmp bx, VGA.Width*VGA.Height-1
	ja .end

	; upload position
	mov dx, 0x3D4
	mov al, 0x0F
	out dx, al

	mov dx, 0x3D5
	mov al, bl
	out dx, al

	mov dx, 0x3D4
	mov al, 0x0E
	out dx, al

	mov dx, 0x3D5
	mov al, bh
	out dx, al

	pop dx
	pop bx
	pop ax

	.end:
	ret

; al - Character to print
PrintChar:
	push eax
	push ebx

	push ax
	mov eax, 0
	call GetCursorIndex
	lea ebx, [0xb8000+eax*2]
	pop ax

	mov [ebx], byte al

	call GetCursorPos
	add ax, 1
	call SetCursorPos

	pop ebx
	pop eax
	ret

; eax - String to print
PrintString:
	push eax
	push bx
	push ecx
	mov ecx, 0
	.start_loop:
	cmp [eax+ecx], byte 0
	je .end_loop
		mov bl, [eax+ecx]
		push ax
		mov al, bl
		call PrintChar
		pop ax
		inc ecx
	jmp .start_loop
	.end_loop:
	call GetCursorPos
	add ax, cx
	call SetCursorPos
	pop ecx
	pop bx
	pop eax
	ret

Newline:
	push ax
	push bx
	call GetCursorPos
	mov ax, 0
	add bx, 1
	call SetCursorPos
	pop bx
	pop ax
	ret
