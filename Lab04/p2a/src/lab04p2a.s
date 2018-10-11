# file: lab04p2a.s
# desc: lab04 p2a
# author: Justin Johnson, Tyler French

.include "macros.inc"

  SET_TARGET

  .text

  FUNCTION main,global

    push {r4,r5,r6,r7,lr}

    ldr  r4,=W		//Establish addressability to W
    ldr  r5,[r4]	//Dereference r4 into r5

    all_done:
    
    pop {r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main

  .data

    .word 0xbbbbbbbb
W:  .word 4277009102
    .word 0xeeeeeeee

  .end
