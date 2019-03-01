			.text
			.global _start


_start:
			LDR R4, =RESULT  // R4 points to result location
			LDR R2, [R4, #4] // R0 = N (Number of elements in list)
			ADD R1, R4, #8   // R1 -> Points to first number
			BL MAX			 // Perform "Branch and Link" instruction, storing PC+4 in the Link register (R14)
							 // and then branch to MAX (PC = MAX)
			B DONE			 // Branch to DONE

// Max (Number of elements, Pointer to first number)
//		R2 -> Number of elements
//		R1 -> Pointer to first number
//		R0 -> Hold max
MAX:		PUSH {R4-R12,LR} // Save state by pushing R4 - LR onto the stack
			LDR R0, [R1]	 // R0 holds the MAXIMUM of the list
LOOP:		SUBS R2, R2, #1  // decrement the loop counter
			BEQ MAXFIN		 // If all elements have been scanned (R2 = 0), branch to finish 		 	 
			ADD R1, R1, #4   // R1 points to next num in list
			LDR R3, [R1]	 // R3 holds the next num in the list
			CMP R0, R3		 // if (R0 > R3) { Compare maximum with current
			BGE LOOP		 // GOTO LOOP
			MOV R0, R3		 // else { R0 = R3 (UPDATE MAXIMUM) }
			B LOOP			 // GOTO LOOP
MAXFIN:		POP {R4-R12,LR}		 // Restore state by popping R4 - LR from stack
			BX LR			 // Branch to LR

DONE:		STR R0, [R4]     // store the result to the memory location

END:		B END			 // infinite loop!

RESULT:		.word	0		   // memory assigned for result location
N:			.word	7		   // number of entries in the list
NUMBERS:	.word	4, 5, 3, 6 // the list data
			.word	1, 8, 2

			
