			.text
			.global _start

_start:
							// NOTE: We LOAD N and SIGNAL to R4 and R5 respectively, making sure we don't overwrite
							// these registeres. We wanted to minimize the number of LDR calls for greater performance
			LDR R4, N		// R4 = N (number of elements)
			LDR R5, =SIGNAL // R5 = pointer to first sample
			MOV R0, R4		// R4 = R0 
			MOV R1, R5		// R1 = R5 = pointer to first sample
			MOV R2, #0		// Initialize R2 (Sum) to 0

FINDSUM:						// do {
			LDR R3,[R1]			// 	R3 = *R1
			ADD R2, R2, R3		// 	R2 = R2 + R3	
			ADD R1, R1, #4		// 	R1 = R1 + 4 
			SUBS R0, R0, #1		// 	R0 = R0 - 1
			BEQ LOG2			// } while (R0 > 0)
			B FINDSUM

								// LOG2: Peforms R3 = Log2(R4)
LOG2:		MOV R0, R4			// R0 = R4 = N
			MOV R3, #0			// R3 = 0
LOOP:		CMP R0, #1			// Perform R0 - 1 and store result in condition code
			BEQ AVG				// while ((R0-1) > 0) {
			ADD R3, R3, #1		// 	R3 = R3 + 1
			ASR R0, R0, #1	 	// 	R0 >>= 1
			B LOOP 				// }	

AVG:							// AVG: Finds R0 = AVG(SIGNAL)
			ASR R0, R2, R3		// R0 = R2 >> R3 (R0 = Sum >> Log2(N) = Sum / N)
			MOV R1, R5			// Reset R1 to first element in list
			B CENTER

CENTER:							// do {
			LDR R3, [R1]		//	R3 = *R1 (get current value)
			SUB R3, R3, R0		//  R3 = R3 - Average
			STR R3, [R1]		//  *R1 = R3  (Update current value with R3)
			ADD R1, R1, #4		// 	R1 = R1 + 4 (Point to next sample)
			SUBS R4, R4, #1		//	Decrement N
			BEQ END				//  GOTO END when complete
			B CENTER			// }
						
END:		B END

N:			.word	8			  // Number of samples in our signal
SIGNAL:		.word	8, 2, 4, 6
			.word	3, 4, 9, 1
