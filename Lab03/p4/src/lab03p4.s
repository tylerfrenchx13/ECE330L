# file: lab03p4.s
# team w4

.include "macros.inc"

  SET_TARGET

  .text

  FUNCTION main,global

    push {r4,r5,r6,r7,lr}

    // Established Addressability
    ldr r7, =DSECT

    //Set shift values
    .equ Left_Shift, 13
    .equ Right_Rotate, 5

    //Load Labels into r4-r6
    ldrb r4, [r7,#A-DSECT]
    ldrh r5, [r7,#B-DSECT]
    ldr r6, [r7,#C-DSECT]

    //Shift contents of labels by Left_Shift
    lsl r4, Left_Shift
    lsl r5, Left_Shift
    lsl r6, Left_Shift

    //rotate contents of labels by Right_Rotate
    ror r4, Right_Rotate
    ror r5, Right_Rotate
    ror r6, Right_Rotate

    all_done:
    
    pop {r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main

  .data
  DSECT:
  .word 0xbbbbbbbb //begin coremark

  //Sets labels with byte, short, and word of data (0x4) respectively
      .align 0
  A:  .byte 0x4

      .align 1
  B:  .short 0x0004

      .align 2
  C:  .word 0x00000004

  .word 0xeeeeeeee
  .end //end coremark
