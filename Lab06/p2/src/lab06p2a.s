# file: lab06p2.s
# team w4
# authors: Justin Johnson, Tyler French

.include "macros.inc"

  SET_TARGET

  .text

	.equ GPIOD_BASE, 0x40020c00 
	.equ GPIO_MODER, 0x00
	.equ GPIO_ODR, 0x14

  FUNCTION main,global

    push {r4,r5,r6,r7,lr}			//push registers onto the stack

    ldr  r4,=GPIOD_BASE				//establish addressability to GPIOD_BASE, using r4
		ldr  r2,=(0b01<<(2*13))		//setting mode to output to pin 13
		str  r2,[r4,#GPIO_MODER]	//store the bits from r2 into MODER register

		ldr r5,=#0				//set off switch
		ldr r6,=#(1<<13)	//set on switch for pin13 (orange)

		str r6,[r4,#GPIO_ODR]	//set the pin13 register to 1 (On)
		str r5,[r4,#GPIO_ODR]	//set the pin13 register to 0 (Off)

    all_done:
    
    pop {r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main

  .data

  .end
