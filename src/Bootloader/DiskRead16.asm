ReadExtendedProgarm:
	pusha

	mov ah, 0x02
	mov bx, ExtendedProgramSpace
	mov al, ExtendedProgramSectors
	mov dl, [BootDisk]
	mov ch, 0x00
	mov dh, 0x00
	mov cl, 0x02

	int 0x13

	jc DiskReadFailed

	cmp al, ExtendedProgramSectors
	jne DiskReadFailed

	popa
	ret

BootDisk:
	db 0

DiskReadFailed:
	mov bx, DiskReadErrorString
	call PrintString
	jmp $

DiskReadErrorString:
	db `Disk read failed\r\n`, 0
