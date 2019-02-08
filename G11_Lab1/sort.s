			.text
			.global _start

_start:
			LDR R4, N			// R4 = N (number of elements)
			LDR R5, =LIST		// R5 = pointer to first element
			MOV R0, #0			// R0 -> SORTED FLAG. (1 = SORTED)

SORT:
			CMP R0, #1			// Peform R0 - 1 and store result in condition code
			BEQ END				// if (R0 == 1) -> SORTED, GOTO END
			MOV R0, #1			// Set R0 to SORTED
			MOV R2, R4			// R2 = R4 = N
			MOV R7, R5			// Point R7 to first element
			ADD R8, R7, #4		// Point R8 to second element
LOOP:		SUBS R2, R2, #1		// R2 = R2 - 1
			BEQ SORT			// If R2 == 0, GOTO SORT
			LDR R1, [R7]		// R1 = *R7 (Assign R1 value R7 points to)
			LDR R3, [R8]		// R3 = *R8 (Assign R3 value R8 points to)
			CMP R1, R3			// Compare value *R7 to value *R8
			BGT SWAP			// if (*R7 > *R8) GOTO SWAP
								// NOTE: GT condition suffix is used in case of DUPLICATES
INCR:		ADD R7, R7, #4		// Point R7 to next element
			ADD R8, R8, #4		// Point R8 to next element
			B LOOP

SWAP:		STR R3, [R7]		// *R7 = value pointed to by R8 (R3)
			STR R1, [R8]		// *R8 = value pointed to by R7 (R1)
			MOV R0, #0			// Set R0 to NOT SORTED
			B INCR				// Increment values		

END:		B END

N:			.word	8			  // Number of element in our list
LIST:		.word	-3, 100, 5, 6
			.word	3, 3, 8, 10