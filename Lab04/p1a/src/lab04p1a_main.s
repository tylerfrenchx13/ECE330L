// file: lab04p1a_main.s
// author: <your-name>

  .include "macros.inc"

  SET_TARGET

  .text
  
  FUNCTION main,global

    push {r4,r5,r6,r7,lr}

      ldr  r4,=AFN
      ldr  r5,[r4]

    all_done: nop

    pop {r4,r5,r6,r7,lr}
  
      bx lr

  ENDFUNC main

  .data

      .word	0xbbbbbbbb
AFN:	.word	305419896
      .word	0xeeeeeeee

  .end
