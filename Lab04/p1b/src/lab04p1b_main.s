// file: main_asm.s
// desc: lab04 p1b
// author: <your-names>

  .include "macros.inc"

  SET_TARGET

  .text
  
  FUNCTION main,global

    push {r4,r5,r6,r7}

      ldr   r4,=DSECT
      ldrb  r5,[r4,X-DSECT]
      ldrh  r6,[r4,Y-DSECT]
      add   r7,r5,r6
      str   r7,[r4,Z-DSECT]

    all_done: nop

    pop {r4,r5,r6,r7}
    
      bx lr

  ENDFUNC main
      
  .data

  .org 234
  .align 2,0xa5
  
DSECT:
     .word 0xbbbbbbbb

X:   .byte 234

     .align 1,0xaa
Y:   .short 56789

     .align 2,0xaa
Z:   .word ~0

     .align 3,0xaa
     .word 0xeeeeeeee

  .end
