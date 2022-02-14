%include "BootloaderInfo.asm"

bits 16
org 0x7c00

mov [BootDisk], dl

mov sp, 0x7c00
mov bp, sp

call ReadExtendedProgarm

jmp ExtendedProgramSpace

SuccessMessage:
	db `Extended bootloader successfuly loaded\r\n`, 0

%include "Print16.asm"
%include "DiskRead16.asm"

times 0x200 - 2 - ($-$$) db 0x00
db 0x55
db 0xAA
