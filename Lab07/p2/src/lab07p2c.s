# file: lab07p2c.s
# team w4
# author: Justin Johnson, Tyler French

.include "macros.inc"

  SET_TARGET

  .text

  FUNCTION main,global

    push {lr}

    bl SW_Init
    bl LEDR_Init

    while:
        
        bl SW_Get_B
        bl decode4x16
        bl gpio_d_put

        b while
    
    pop {lr}
    bx lr
  
  ENDFUNC main

  .end
