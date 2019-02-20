

//taken from link      https://rosettacode.org/wiki/Fibonacci_sequence#8080_Assembly
	.text
	.global _start


_start:
	push{r1-r3}
	ldr r1, #0 
	ldr r2, #1

FIB: 
	mov r3, r2
	add r2, r1, r2
	mov r1, r3
	sub r0, r0, #1
	cmp r0, #1
	bne  fibloop 

	mov r0, r2
	pop {r1-r3}
	mov pc, lr 



RESULT: .word 0 

N: .word 4