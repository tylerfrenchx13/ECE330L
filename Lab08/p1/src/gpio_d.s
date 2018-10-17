# file: gpio_d.s
# author: Justin Johnson, Tyler French
# team w4

.include "macros.inc"
.include "src/gpio_regs.inc"

  SET_TARGET

  .text

  FUNCTION gpio_d_init,global

    push {lr}

		mov r0,#3						//send 3 as arg to rcc function
		bl rcc_gpio_enable				//call rcc function

		ldr r3, =#GPIOD_BASE			//load r3 with the base address of PORT D

		ldr r2, =#0x00000000			//load 0 into r2
		str r2,[r3,#GPIO_PUPDR]			//write Port D PUPDR register as no pull-up, no pull-down
		str r2,[r3,#GPIO_OTYPER]		//write Port D OTYPER register as reset state
		str r2,[r3,#GPIO_ODR]			//write 0 to GPIO Port D output data register

		ldr r2,=#0x55555555				//set all 16 bits of Port D to outputs
		str r2,[r3,#GPIO_MODER]

		ldr r2,=#0xffffffff				//load all ones into r2
		str r2,[r3,#GPIO_OSPEEDR]		//set Port D SPEEDR register as high speed

		pop {lr}

    bx lr
  
  ENDFUNC gpio_d_init

  FUNCTION gpio_d_put,global

		push {lr}

		ldr r3, =#GPIOD_BASE		//load r3 with the base address of Port D

		str r0,[r3,#GPIO_ODR]		//write r0 to GPIO Port D output

		pop {lr}

		bx lr

  ENDFUNC gpio_d_put

  FUNCTION gpio_d_get_current,global

        push {lr}

        ldr r3,=#GPIOD_BASE         //load r3 with base register address of port D
        ldr r0,[r3,#GPIO_ODR]       //load r0 (return arg) with GPIO D output data register

        pop {lr}

        bx lr

  ENDFUNC gpio_d_get_current

  .end
