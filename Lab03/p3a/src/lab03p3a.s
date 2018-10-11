# file: lab03p3a.s
# team w4

.include "macros.inc"

  SET_TARGET

  FUNCTION main,global

    push {r4,r5,r6,r7,lr}

    ldr  r4,=(1<<31)-1 //shifts '0x0001' left 31 times, and subtracts 1
    mov  r5,4 //puts '4' into r5
    adds r2,r4,r5 //sets code flags on result. Adds r4 and r5, stores in r2

    all_done:
    
    pop {r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main

  .end
