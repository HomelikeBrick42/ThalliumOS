%include "BootloaderInfo.asm"

bits 16
org ExtendedProgramSpace

call EnableA20
cli
lgdt [GDT_Desc]
mov eax, cr0
or eax, 1
mov cr0, eax
jmp CodeSeg:StartProtectedMode

EnableA20:
	in al, 0x92
	or al, 2
	out 0x92, al
	ret

bits 32

StartProtectedMode:
	mov ax, DataSeg
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov esp, 0x90000
	mov ebp, ebp

	; Reset screen and cursor
	call ClearScreen

	mov ax, 0
	mov bx, 0
	call SetCursorPos

	jmp Bootloader32

%include "GDT.asm"
%include "Bootloader32.asm"
%include "VGA32.asm"

times (1024*ExtendedProgramSectors) - ($-$$) db 0x00
