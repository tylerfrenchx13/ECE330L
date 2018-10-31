# file: lab08p1a.s
# authors:  Justin Johnson, Tyler French
# Team: w4

.include "macros.inc"

  SET_TARGET

  .text

  FUNCTION main,global

    push {r4,r5,r6,r7,lr}

    bl gpio_c_init
    bl gpio_d_init

    while:
      bl sw_get_index
      bl led_put_index

      bl sw_get_segments
      bl led_put_segments

      b while

    all_done:
    
    pop {r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main

  .data


SEG7HEX:  .byte 0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa
          .byte 0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa
  .end
