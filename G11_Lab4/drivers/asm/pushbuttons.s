		.text
		.equ PB_BASE, 0xFF200050
		.equ PB_INT, 0xFF20005C

		.global read_PB_data_ASM, read_PB_edgecap_ASM
		.global PB_data_is_pressed_ASM, PB_edgecap_is_pressed_ASM, PB_clear_edgecap_ASM
		.global enable_PB_INT_ASM, disable_PB_INT_ASM, 



read_PB_data_ASM:
					LDR R0, =PB_BASE
					LDR R0, [R0]
					BX LR   					//Return to Link register

read_PB_edgecap_ASM:
					LDR R0,=PB_INT
					LDR R0, [R0]
					AND R0, R0, #oxF
					BX LR 						//Return to Link register


PB_data_is_pressed_ASM:
					MOV R3, R0
					MOV R0, #0 //set to false by default
					LDR R1, =PB_BASE	
					LDR R2, [R1]		
					ANDS R2, R2, R3 	
					MOVEQ R0, #1 			
					BX LR    				//Return to Link register



PB_edgecap_is_pressed_ASM:
					MOV R3, R0
					MOV R0, #0
					LDR R1, =PB_INT	
					LDR R1, [R1]	
					ANDS R2, R1, R3				
					MOVEQ R0, #1			
					BX LR


PB_clear_edgecap_ASM:
					LDR R2, =PB_INT
					MOV R1, #0x7
					STR R1, [R2]	
					BX LR

enable_PB_INT_ASM:
					LDR R2, =PB_BASE	
					AND R1, R0, #0xF	
					STR R1, [R2, #0x8]	
					BX LR

disable_PB_INT_ASM:
					LDR R2, =PB_BASE	
					LDR R1, [R2, #0x8]	
					BIC R1, R1, R0		
					STR R1, [R2, #0x8]	
					BX LR


	.end