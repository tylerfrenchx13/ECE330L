# file: decode4x16.s
# author: Justin Johnson, Tyler French
# team w4

.include "macros.inc"
.include "src/gpio_regs.inc"

  SET_TARGET

  .text

  FUNCTION decode4x16,global

    push {r4,lr}

    mov r1,#0b1         //set new value
    lsl r0,r1,r0        //shift new value by r0 into r0

    pop {r4,lr}

    bx lr

  ENDFUNC decode4x16

  .end
