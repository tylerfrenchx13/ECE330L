# file: lab08p1b.s
# authors:  Justin Johnson, Tyler French
# Team: w4

.include "macros.inc"

  SET_TARGET

  .text

  FUNCTION main,global

    push {r4,r5,r6,r7,lr}

    bl gpio_c_init
    bl gpio_d_init
    bl seg7_init

    while:
      bl sw_get_index
      bl led_put_index

      bl sw_get_segments
      bl led_put_segments

      bl sw_get_segments      //retrieve for param2
      mov r4,r0               //save param in r4
      bl sw_get_index         //retrieve for param1 & store in r0
                                                  //r0                r1
      mov r1,r4               //set param2 as r1 (previously saved in r4)
      bl seg7_put             //void seg7put(unsigned int segid, unsigned int segments);

      b while

    all_done:
    
    pop {r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main

  .data


SEG7HEX:  .byte 0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa
          .byte 0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa
  .end
