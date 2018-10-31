# file: lab03p3b.s
# team w4

.include "macros.inc"

  SET_TARGET

  FUNCTION main,global

    push {r4,r5,r6,r7,lr}

    mov r4, #7      //puts 7 into r4
    mov r5, #13     //puts 13 into r5
    subs r6, r4, r5 //subtracts the value of r5 from the value of r4, and stores the result in r6 

    all_done:
    
    pop {r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main

  .end
