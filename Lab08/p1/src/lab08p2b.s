# file: lab08p2b.s
# authors:  Justin Johnson, Tyler French
# Team: w4

.include "macros.inc"

  SET_TARGET

  .text

  FUNCTION main,global

    push {r4,r5,r6,r7,lr}

    ldr r7,=SEG7HEX           //establish addressability to array

    bl gpio_c_init            //initialize ports
    bl gpio_d_init
    bl seg7_init

    while:
      bl sw_get_index         //set LED's with corresponding switches
      bl led_put_index

      bl sw_get_hex           //retrieve for param2
      mov r4,r0               //save param in r4
      ldrb r5,[r7,r4]         //load into r4 index (r4) at array (r7)


      bl sw_get_latch         //get lock (1 is locked, 0 is unlocked)
      cbnz r0, display        //if r0 is 1, branch to while (via display label below), if 0 continue

      bl sw_get_index         //retrieve for param1 & store in r0
                                                  //r0                r1
      mov r1,r5               //set param2 as r1 (previously saved in r4)
      bl seg7_put             //void seg7put(unsigned int segid, unsigned int segments);

      display:
      b while

    all_done:
    
    pop {r4,r5,r6,r7,lr}

    bx lr
  
  ENDFUNC main

  .data


          //array: [0-9,a-f]
SEG7HEX:  .byte 0x40,0x79,0x24,0x30,0x19,0x12,0x2,0x78
          .byte 0x0,0x10,0x8,0x3,0x46,0x21,0x6,0xe
  .end
