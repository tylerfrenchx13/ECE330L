# file: lab06p3.s
# team w4
# authors: Justin Johnson, Tyler French

.include "macros.inc"

  SET_TARGET

  .text

	.equ GPIOD_BASE, 0x40020c00 
	.equ GPIO_MODER, 0x00
	.equ GPIO_ODR, 0x14

  FUNCTION main,global

    push {r0,r3,r4,r5,r6,r7,lr}			//push registers onto the stack

    ldr  r4,=GPIOD_BASE				//establish addressability to GPIOD_BASE, using r4
		ldr  r2,=(0b01<<(2*14))		//setting mode to output to pin 13
		str  r2,[r4,#GPIO_MODER]	//store the bits from r2 into MODER register

		ldr r5,=#0				//set off switch
		ldr r6,=#(1<<14)	//set on switch for pin14 (red)
		
		A: 

		str r6,[r4,#GPIO_ODR]	//set the pin13 register to 1 (On)
		ldr r0,=1000000		//load r0 with 1000000
		bl delay		//call delay function
		str r5,[r4,#GPIO_ODR]	//set the pin13 register to 0 (Off)
		ldr r0,=1000000		//load r0 with 1000000
		bl delay		//call delay function
	
		b A

    all_done:
    
    pop {r0,r3,r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main

  FUNCTION  delay

	mov r3,#0	//put 0 into r3
	
	delay_loop:
	
		sub r0,#1	//subtract 1 from r0
		cmp r0,r3	//compare r0 and r3, set a flag
		bge delay_loop

	bx lr

  ENDFUNC delay 

  .data

  .end
