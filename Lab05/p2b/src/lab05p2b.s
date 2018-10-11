# file: lab05p2b.s
# team w4
# author: Justin Johnson, Tyler French

.include "macros.inc"

  SET_TARGET

  .text

  FUNCTION main,global

    push {r4,r5,r6,r7,lr}

    ldr  r4,=DS         //Establish addressability to r4
    ldrh  r5,[r4,A-DS]  //Load label A into r5 as a short
    ldr  r6,[r4,B-DS]   //Load label B into r6 as a word

    all_done:
    
    pop {r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main

  .data

      .align 2,0xaa
DS: 
      .align 1,0xaa
A:    .short 0xabcd

      .align 2,0xaa
B:    .word 0x12345678

  .end
