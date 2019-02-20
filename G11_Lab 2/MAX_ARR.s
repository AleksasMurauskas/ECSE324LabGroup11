	.text
	.global MAX_ARR 


MAX_ARR:
	LDR R4, = RESULT // Holds the result location 
	LDR R2, N //Array size
	LDR R1, ARR //Points to the front of the array 
	LDR R0, [R1]; //Holds max, holds the beginning of the array at the start 
	SUB R1, R1, #4 //Sets it before the array


LOOP: 
	SUBS R2, R2, #1    //Loop invariant
	BEQ DONE          //Loop Completed
	ADD R1, R1, #4   //R1 Points to next in the array 
	B COMP            //Comparison 

COMP:
	CMP R1, R0    //Perform R1 (Current) - R0 (MAX)
	BGE LOOP      //Max is larger 
	MOV R0, R1   //Max is updated 
	B LOOP        //Return to loop

DONE:
	STR R2, [R4]   //Store end result 
	B END 


END: 	B END //



RESULT: 	.word 0 //Assigned result location 

N:			.word 7 // Number of entries

NUMBERS: 	.word 4, 5, 3, 6		//List Data  
 					.word 1, 8, 2