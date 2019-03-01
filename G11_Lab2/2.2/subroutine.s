		.text
		.global MAX_2

MAX_2:
		CMP R0, R1		// R0 - R1 -> store result in CSPR
		BXGE LR			// If (R0 > R1) { GOTO: LR }
		MOV R0, R1		// R0 = R1 (update maximum)
		BX LR			// GOTO: LR
		.end