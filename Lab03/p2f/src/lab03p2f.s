# file: lab03p2f.s
# team w4

.include "macros.inc"

  SET_TARGET

  FUNCTION main,global

    push {r4,r5,r6,r7,lr}

    ldr  r4,=0xFFFFFFFF //loads hex value into r4
    ldr  r5,=0x12345678 //loads hex value into r5
    orr  r6,r4,r5       //performs logical OR between r4 and r5, and stores result in r6

    all_done:
    
    pop {r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main

  .end
