# file: lab03p2a.s
# team w4

.include "macros.inc"

  SET_TARGET

  FUNCTION main,global

    push {r4,r5,r6,r7,lr}

    ldr  r4,=68 //Load 68 into r4
    ldr  r5,=45 //Load 45 into r5
    add  r2,r4,r5 //Add r5 and r4, store in r2

    all_done:
    
    pop {r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main

  .end
