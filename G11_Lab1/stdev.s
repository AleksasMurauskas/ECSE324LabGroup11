			.text
			.global _start
// LDR -> 

_start:
			LDR R4, =RESULT  // R4 points to result location
			LDR R2, [R4, #4] // R2 holds the number of elements in the list
			ADD R3, R4, #8   // R3 points to the first number
			LDR R0, [R3]	 // R0 -> MAX OF LIST
			LDR R5, [R3]	 // R5 -> MIN OF LIST
			

LOOP:		SUBS R2, R2, #1  // decrement the loop counter
			BEQ DONE		 // end loop if counter has reached 0
			ADD R3, R3, #4   // R3 points to next num in list
			LDR R1, [R3]	 // R1 -> CURRENT NUMBER
			B CHECKMAX		 // Initially check for max

CHECKMAX:	CMP R0, R1		// Perform R0 (MAX) - R1 (CURRENT). Store result into condition code
			BGE CHECKMIN	// Branch to CHECKMIN if condition code > 0
			MOV R0, R1		// Update R0 (MAX) with R1 (CURRENT)
			B LOOP			// Branch to LOOP

CHECKMIN:	CMP R1, R5		// Perform R1 (CURRENT) - R5 (MIN). Store result into condition code
			BGE LOOP		// Branch to LOOP if condition code > 0
			MOV R5, R1		// Update R5 (MIN) with R1 (CURRENT)
			B LOOP			// Branch to LOOP
				

DONE:		SUB R2, R0, R5   // Perform R2 = R0 (MAX) - R5 (MIN) 
			ASR R2, R2, #2	 // Perform R2>>=2 (Equiv to R2/=4)
			STR R2, [R4]     // store R2 (Standard deviation) to the memory location		

END:		B END			 // infinite loop!

RESULT:		.word	0		   // memory assigned for result location
N:			.word	7		   // number of entries in the list
NUMBERS:	.word	10, 40, 23, 3 // the list data
			.word	1000, 32, 5

			
