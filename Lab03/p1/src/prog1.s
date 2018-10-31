# file: prog1.s
# Team w4

.include "macros.inc"

  SET_TARGET

  FUNCTION main,global

    push {r4,r5,r6,r7,lr}

    ldr  r4,=0x11223344 //Loads hex value into r4
    ldr  r5,=0x55667788 //Loads hex value into r5
    add  r2,r4,r5 //Adds contents of r5 and r4, stores into r2

    all_done:
    
    pop {r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main

  .end
