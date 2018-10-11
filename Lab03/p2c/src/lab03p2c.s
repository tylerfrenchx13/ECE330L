# file: lab03p2c.s
# team w4

.include "macros.inc"

  SET_TARGET

  FUNCTION main,global

    push {r4,r5,r6,r7,lr}

    ldr  r4,=68 //Load 68 into r4
    ldr  r5,=45 //Load 45 into r5
    mvn  r6,r5  //Moves contents of r5 into r6
    add  r6,1 	//adds 1 to the contents of r6 (stored in r6)
    add  r2,r4,r6 //adds contents of r6 and r4, stores in r2

    all_done:
    
    pop {r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main

  .end
