		.text

		.global read PS2_data_ASM

		.equ PS2_DATAREG, 0xFF200100
		.equ PS2_CONTROLLERREG, 0xFF200104


read_PS2_data_ASM: //Parameters R0 is the character pointer

	PUSH {R4-R10}
	LDR R2, = PS2_DATAREG
	LDR R1, [R2]
	MOV R3, #0x*8000
	MOV R4, #0xFF
	AND R5, R1, R3
	CMP R5 , #0
	BEQ NO_DATA_EXCEPTION

	AND R6, R1, R4
	STRB R6, [R0] 


	POP {R4-R10}
	MOV R0, #1 //Return true to show success
	BX LR 



NO_DATA_EXCEPTION: 
	
		MOV R0, #0 //Return 0 to show it has failed
		BX LR


		.end 