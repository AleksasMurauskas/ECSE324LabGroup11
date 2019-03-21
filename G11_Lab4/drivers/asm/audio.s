	.text

	.global write_audio_FIFO_ASM
	.equ FIFO_LOCATION, 0xFF203044
	.equ LEFT_LOCATION,0xFF203048
	.equ RIGHT_LOCATION,0xFF20304C



write_audio_FIFO_ASM: // Parameter R0 = data_to_be_written
	LDR R1, =FIFO_LOCATION
	LDR R2, =LEFT_LOCATION
	LDR R3, =RIGHT_LOCATION
	LDR R4, [R1]
	MOV R5, R3, LSR  #16
	LDRB R6,[R5]

	//These checks could also be accomplished with a ands comparing the value with it self,
	//If any 1s appear that means something is already in that position

	CMP R6, #1  //Checks to see if there is An empty position
	BLT FAILURE

	MOV R5, R5, LSR #8 
	LDRB R7, [R5] 

	CMP R7, #1 
	BLT FAILURE

	STR R0, [R2]
	STR R0, [R3]
	
	MOV R0,#1 //Return 1 for a success state 
	B END 

FAILURE:
	MOv R0, #0 //Return 0 For a failure state 
END:
	BX LR