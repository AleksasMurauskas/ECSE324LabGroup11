			.text
			.global _start


_start:
			LDR R4, =RESULT		 // R4 points to result location
			LDR R0, [R4, #4]	 // R0 = Nth Fibonacci number to calculate
			BL FIB				 // Perform branch and link to FIB routine
			STR R0, [R4]		 // Store result from fibonacci routine at RESULT memory location
			B END				 // Branch to end

// Fib(n):
// 	if n >= 2:
//		return Fib (n-1) + Fib(n-2)
// 	if n < 2:
// 		return 1

FIB: // Fib(R0) -> Return the nth Fibonacci number in R0.
	 // 	R0 -> Nth Fibonacci number to calculate to
			PUSH {R4-R12,LR} // Save state of the processor before entering sub-routine
			CMP R0, #2		 // Compare R0 to 2 (I.E. perform R0 - 2 and store in CPSR)
			BGE RECURSE 	 // if (n >= 2) { goto RECURSE }
			MOV  R0, #1		 // R0 = 1 (Set return value to 1)
			POP {R4-R12,LR}	 // Restore state of processor before exiting sub-routine
			BX LR			 // Branch to LR
RECURSE:	SUB R4, R0, #1	 // R4 = R0 - 1
			SUB R5, R0, #2   // R5 = R0 - 2
			MOV R0, R4		 // R0 = R4 = (n-1)
			BL FIB			 // Recursively call Fib(R0) (Or Fib(n-1))
			MOV R4, R0		 // R4 = R0 (n-1)th fubibacci number
			MOV R0, R5		 // R0 = R5 = (n-2)
			BL FIB			 // Recursively call Fib(R0) (Or Fib(n-2))
			MOV R5, R0		 // R5 = R0 (n-2)th fibonacci number
			ADD R0, R4, R5   // R0 = R4 + R5 (Eq: Fib (n-1) + Fib (n-2))
			POP {R4-R12,LR}	 // Restore state of processor before exiting sub-routine
			BX LR			 // Branch to LR

END:		B END			 // Infinite loop

RESULT:		.word	0 		 // Result location memory
N:			.word	5		 // Nth fib number to calculate to
