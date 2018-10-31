# file: lab05p2a.s
# team: w4

.include "macros.inc"

  SET_TARGET

  .text

  FUNCTION main,global

    push {r4,r5,r6,r7,lr}

    ldr  r4,=A  //Establish Addressability
    ldrh r5,[r4] //load half word into register 5

    all_done:
    
    pop {r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main

  .data

A:  .short 0xabcd

  .end
