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

	mov [0xb8000], byte 'H'
	mov [0xb8002], byte 'e'
	mov [0xb8004], byte 'l'
	mov [0xb8006], byte 'l'
	mov [0xb8008], byte 'o'

	jmp $

%include "GDT.asm"

times (1024*ExtendedProgramSectors) - ($-$$) db 0x00
