# file: lab03p2e.s
# team w4

.include "macros.inc"

  SET_TARGET

  FUNCTION main,global

    push {r4,r5,r6,r7,lr}

    ldr  r4,=0xFFFFFFFF //Loads hex into r4
    ldr  r5,=0x12345678 //Loads hex into r5
    and  r6,r4,r5 // performs logical and on r4 and r5 and stores into r6

    all_done:
    
    pop {r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main

  .end
