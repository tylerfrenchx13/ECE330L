# file: lab05p2c.s
# team w4
# author: Justin Johnson, Tyler French

.include "macros.inc"

  SET_TARGET

  .text

  FUNCTION main,global

    push {r4,r5,r6,r7,lr}

    adr   r4,DS         //Establish addressability using adr instruction
    ldrh  r5,[r4,A-DS]  //load short into r5 from label A
    ldr   r6,[r4,B-DS]  //load short into r6 from label B

    all_done:
    
    pop {r4,r5,r6,r7,lr}

    bx lr

      .align 2,0xaa
DS:
      .align 1,0xaa
A:    .short 0xabcd

      .align 2,0xaa
B:    .word 0x12345678
  
  ENDFUNC main

  .end
