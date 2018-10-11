# file: lab04p2b.s
# desc: lab04 p2b
# author: Justin Johnson, Tyler French

.include "macros.inc"

  SET_TARGET

  .text

  FUNCTION main,global

    push {r4,r5,r6,r7,lr}

    ldr r4,=DS		//use register r4 to establish addressability to symbol DS
    ldrb r5,[r4,B-DS]	//load the value of label B into register r5
    ldr r6,[r4,W-DS]	//load the value of label W into register r6

    all_done:
    
    pop {r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main

  .data

    .org 300

    .align 2,0xaa
    .word 0xbbbbbbbb

B:  .byte 85

    .align 2, 0xaa
DS: .word ~0

    .align 2, 0xaa
W:  .word 287454020

    .word 0xeeeeeeee

  .end
