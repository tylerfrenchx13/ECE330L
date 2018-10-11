# file: lab04p3.s
# desc: lab04 p3
# author: Justin Johnson, Tyler French

.include "macros.inc"

  SET_TARGET

  .text

  FUNCTION main,global

    push {r4,r5,r6,r7,lr}

    ldr 	r4,=DS //Establish Addressability
	ldrb	r5,[r4,#A-DS]  //Load A into r5
	ldrh	r6,[r4,#B-DS]  //Load B into r6
	add	r7,r5,r6  // add r5 and r6, store in r7
	str	r7,[r4,#C-DS] //store value back into memory
	
    all_done:
    
    pop {r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main

  .data
  
  .org 234
  .align 2,0xa5

DS:   .word  0xbbbbbbbb

A:    .byte  123

      .align 1,0xa5
B:    .short 47587

      .align 2,0xa5
C:    .word  ~0

      .align 3,0xa5
      .word  0xeeeeeeee

  .end
