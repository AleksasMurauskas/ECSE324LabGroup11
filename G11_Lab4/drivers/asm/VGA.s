
	.text 

	.equ PIXEL_BUFFER, 0xC8000000
	.equ CHAR_BUFFER, 0xC9000000

	.global VGA_clear_charbuff_ASM //No parameters
	.global VGA_clear_pixelbuff_ASM // No parameters  
	.global VGA_write_char_ASM //parameters x[R0], y[R1], char c[R2]
	.global VGA_write_byte_ASM //parameters x[R0], y[R1], char byte[R2]

	.global VGA_draw_point_ASM //parameters x[R0], y[R1], short colour[R2]

	OFFSET .req R6


VGA_clear_charbuff_ASM:
	//Initialize clearance loops
	PUSH {R0-R10,LR} //PUSH the state for the function call
	LDR R2,=CHAR_BUFFER //Holds  the location of the CHAR_BUFFER
	MOV R3, #0  //Holds the x counter
	MOV R4, #-1   //Holds the y counter 
	MOV R5, #0   // Holds an empty value
	MOV R7, #0 // Holds Final Character address
	MOV R8, #0 

CLEAR_CHARY_LOOP:
	ADD R4,R4, #1 //Increment the X value
	CMP R4, #80 // There are 80 rows being filled 
	BEQ COMPLETE_CHAR_LOOP 
	MOV R3, #0 //New X row, reset the value

CLEAR_CHARX_LOOP:
	CMP R3 #,60 // Loop while x <=59
	BEQ CLEAR_CHARY_LOOP
	//Loop operates
	LSL OFFSET, R3, #7
	ORR OFFSET, OFFSET, R4
	ADD R7, R2, OFFSET
	STRB R8, [R7]    //Sotre 0 at the char address
	ADD R3,R3,#1
	B CLEAR_CHARX_LOOP
COMPLETE_CHAR_LOOP:
	POP {R0-R10,LR}
	BX LR
//Completed 






VGA_clear_pixelbuff_ASM:
	//Initialize clearance loops
	PUSH {R0-R10,LR} //PUSH the state for the function call
	LDR R2,=CHAR_BUFFER //Holds  the location of the PIXEL_BUFFER
	MOV R3, #0  //Holds the x counter
	MOV R4, #-1   //Holds the y counter 
	MOV R5, #0   // Holds an empty value
	MOV R7, #0 // Holds Final Character address
	MOV R8, #0 //Holds empty value


CLEAR_PIXELY_LOOP:
	ADD R4,R4, #1 //Increment the X value
	CMP R4, #320 //320 is the resolution of a Pixel 
	BEQ COMPLETE_PIXEL_LOOP 
	MOV R3, #0 //New X row, reset the value

CLEAR_PIXELX_LOOP:
	CMP R3 #240 // Loop while x <=59
	BEQ CLEAR_PIXELY_LOOP
	//Loop operates
	LSL OFFSET, R3, #10
	LSL R9, R4, #1
	ORR OFFSET, OFFSET, R9
	ADD R7, R2, OFFSET
	STRH R8, [R7]    //Store 0 at the char address
	ADD R3,R3,#1
	B CLEAR_PIXELX_LOOP



COMPLETE_PIXEL_LOOP:
	POP {R0, R10,LR}
	BX LR



VGA_write_char_ASM: //parameters include R0 =x, R1 = y, R2 char c
	PUSH {R4-R10,LR}

	LDR R3, #80
	LDR R4, #60
	//Check Validity of X
	CMP R0, R4 //Is it too large?
	BGE COMPLETE_WRITE_CHAR 
	CMP R0, #0 // Is it too small
	BLT COMPLETE_WRITE_CHAR 
	//Check Validity of Y
	CMP R1, R3 //Is it too large?
	BGE COMPLETE_WRITE_CHAR 
	CMP R1, #0 // Is it too small
	BLT COMPLETE_WRITE_CHAR 

	MOV R3, #0 //Y offset
	MOV R4, #7 //X offset

	LDR R5, =CHAR_BUFFER
	LSL OFFSET, R0, 
	ORR OFFSET, OFFSET, R1
	ADD R4, R5, OFFSET

	STRB R2, [R4] 

COMPLETE_WRITE_CHAR:
	POP {R4-R10,LR}
	BX LR






VGA_write_byte_ASM: //parameters include R0 =x, R1 = y, R2 char c
	PUSH {R4-R10,LR}
	LDR R5, CHAR_IN_HEX
	MOV R3, R2 
	LSR R2, R3, #4
	AND R2, R2, #15
	LDRB R2, [R5, R2]
	BL VGA_write_char_ASM
	AND R2, R3 #15
	ADD R0, R0, #1 // Unsure if this should be y or X 
	BL VGA_write_char_ASM

	POP {R4-R10,LR}
	BX LR


VGA_draw_point_ASM: //parameters include R0 =x, R1 = y, R2 char c
	PUSH {R4-R10,LR}
	LDR R5, =PIXEL_BUFFER //Set the base
	MOV R6, R2

	LSL OFFSET, R0, #10 // Shift X offset
	LSL R8, R1, #1
	ADD OFFSET, OFFSET, R8
	ADD R4, R5, OFFSET
	STRH R6, [R4]

	POP {R4-R10,LR}
	BX LR



CHAR_IN_HEX: .ascii "0123456789ABCDEF"

.end