# file: gpio_regs.inc
# team w4
# author: Justin Johnson, Tyler French

	.equ GPIOA_BASE, 0x40020000
	.equ GPIOB_BASE, 0x40020400
	.equ GPIOC_BASE, 0x40020800
	.equ GPIOD_BASE, 0x40020c00
	.equ GPIOE_BASE, 0x40021000

	.equ GPIO_MODER, 0x00
	.equ GPIO_OTYPER, 0x04
	.equ GPIO_OSPEEDR, 0x08
	.equ GPIO_PUPDR, 0x0c
	.equ GPIO_IDR, 0x10
	.equ GPIO_ODR, 0x14
	.equ GPIO_BSRR, 0x18
	.equ GPIO_LCKR, 0x1c
	.equ GPIO_AFRL, 0x20
	.equ GPIO_AFRH, 0x24


