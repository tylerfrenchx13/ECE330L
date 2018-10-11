# file: lab07p2a.s
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
        
        bl SW_Get_A
        bl LEDR_Put_A

        b while
    
    pop {lr}
    bx lr
  
  ENDFUNC main

  .end
