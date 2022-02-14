GDT_NullDesc:
	dd 0
	dd 0

GDT_CodeDesc:
	dw 0xFFFF
	dw 0x0000
	db 0x00
	db 10011010b
	db 11001111b
	db 0x00
GDT_DataDesc:
	dw 0xFFFF
	dw 0x0000
	db 0x00
	db 10010010b
	db 11001111b
	db 0x00
GDT_End:

GDT_Desc:
	dw GDT_End - GDT_NullDesc - 1
	dd GDT_NullDesc

CodeSeg equ GDT_CodeDesc - GDT_NullDesc
DataSeg equ GDT_DataDesc - GDT_NullDesc
