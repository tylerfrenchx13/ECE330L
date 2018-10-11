# file: lab03p2d.s
# team w4

.include "macros.inc"

  SET_TARGET

  FUNCTION main,global

    push {r4,r5,r6,r7,lr}

    ldr  r4,=0x1111 //loads hex into r4
    lsl  r4,3       //shifts bits of r4 to the left by 3
    lsr  r4,2       //shifts bits of r4 to the right by 2

    all_done:
    
    pop {r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main

  .end
