		.text

		.global read PS2_data_ASM

		.equ PS2_DATAREG, 0xFF200100
		.equ PS2_CONTROLLERREG, 0xFF200104


read_PS2_data_ASM: //Parameters R0 is the character pointer

	LDR R2, = PS2_DATAREG
	LDR R1, [R2]
	MOV R3, #0x*8000
	MOV R4, #0xFF
	AND R5, 