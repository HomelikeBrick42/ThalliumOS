%include "BootloaderInfo.asm"

bits 16
org ExtendedProgramSpace

mov bx, LoadSuccessMessage
call PrintString

jmp $

LoadSuccessMessage:
	db `Extended bootloader successfuly loaded\r\n`, 0

%include "Print16.asm"

times (1024*ExtendedProgramSectors) - ($-$$) db 0x00
