	.text
	.global MAX_ARR 


MAX_ARR:
	LDR R2, N //Array size
	LDR R1, ARR //Points to the front of the array 
	LDR R0, [R1]; //Holds max, holds the beginning of the array at the start 
	//SUB R1, R1, #4 //Sets it before the array


LOOP: 
	SUBS R0, R0, #1    //Loop invariant
	BEQ DONE
	ADD R1, R1, #4
	B COMP 

COMP:
	CMP R1, R2
	BGE LOOP
	MOV R2, R1
	B LOOP   

DONE:
	B END 
