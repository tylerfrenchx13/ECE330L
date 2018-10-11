# file: gpio_c.s
# author: Tyler French

.include "macros.inc"
.include "src/gpio_regs.inc"

  SET_TARGET

  .text

  FUNCTION gpio_c_init,global

    push {lr}

		mov r0,#2										//send 2 as arg to rcc function
		bl rcc_gpio_enable					//call rcc function

		ldr r3, =#GPIOC_BASE				//load r3 with the base address of PORT C

		ldr r2, =#0x00000000				//load 0 into r2
		str r2,[r3,#GPIO_PUPDR]			//write Port C PUPDR register as no pull-up, no pull-down
		str r2,[r3,#GPIO_MODER]			//write Port C MODER register as input
		str r2,[r3,#GPIO_OTYPER]		//write Port C OTYPER register as reset state

		ldr r2,=#0xffffffff					//load all ones into r2
		str r2,[r3,#GPIO_OSPEEDR]		//set Port C SPEEDR register as high speed

		pop {lr}

    bx lr
  
  ENDFUNC gpio_c_init

  FUNCTION gpio_c_get,global

		push {lr}

		ldr r3,=#GPIOC_BASE			//load r3 with the base address of Port C

		ldr r0,[r3,#GPIO_IDR]		//load r0 with the GPIO Port C input data register

		pop {lr}

		bx lr

	ENDFUNC gpio_c_get

  .data

  .end
