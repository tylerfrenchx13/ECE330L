# file: lab07p1.s
# team w4
# author: Justin Johnson, Tyler French

.include "macros.inc"

  SET_TARGET

  .text

  FUNCTION main,global

    push {lr}

    bl gpio_c_init
    bl gpio_d_init

    while:

	bl gpio_c_get
	bl gpio_d_put

	b while
    
    pop {lr}

    bx lr
  
  ENDFUNC main

  .end
