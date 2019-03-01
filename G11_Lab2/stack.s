			.text
			.global _start

_start:
			MOV R0, #8			// R0 = 8
			MOV R1, #2			// R1 = 2
			MOV R2, #9			// R2 = 9
			B PUSHR0			// PUSH R0 onto the stack

PUSHR0:		// PUSHR0: Pushes R0 onto the stack using STR
			STR R0, [SP, #-4]!	// Store R0 at (SP - 4) memory location. Use writeback suffix to set SP = SP-4 
								// after the operation is complete
			PUSH {R1, R2}		// Push R1 and R2 onto the stack
			B POPR0R2			// Branch to POPR0R2

POPR0R2:	// POPR0R2: Pop R0 - R2 from the stack using LDMIA
			// op{addr_mode}{cond} Rn{!}, reglist
			LDMIA SP!, {R0-R2}		// LDMIA -> Load multiple registeres
									// with address mode IA (Increment After)
									// SP -> register on which the memory addresses are based
									// ! -> writeback suffix. final address will be written into SP
									// {R0-R2} -> List of registers to be loaded
			B END				// Branch to END

END:		B END				// Infinite loop
