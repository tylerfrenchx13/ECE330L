# file: SW.s
# author: Justin Johnson, Tyler French
# team w4

.include "macros.inc"
.include "src/gpio_regs.inc"

  SET_TARGET

  .text

  FUNCTION SW_Init,global

    push {lr}

    bl gpio_c_init              //initialize GPIO port A as input

    pop {lr}

    bx lr
  
  ENDFUNC SW_Init

  FUNCTION SW_Get_A,global

    push {lr}

    bl gpio_c_get               //get all 32 bits of port A

    lsr r0,#3                   //normalize bit 3

    ldr r1,=#0x1             //create mask for bit 3

    and r0,r1                   //apply mask

    pop {lr}

    bx lr

  ENDFUNC SW_Get_A

  FUNCTION SW_Get_B,global

    push {lr}

    bl gpio_c_get           //get all 32 bits of input
    lsr r0,#8
    ldr r1,=#(~(~0<<4))     //create mask for bits
    and r0,r1               //islolate bits [11:8]

    pop {lr}

    bx lr

  ENDFUNC SW_Get_B

  FUNCTION sw_get_index,global

    push {lr}

    bl gpio_c_get           //get all 32 bits of input
    lsr r0,#12              //Normalize Bits
    ldr r1,=#(~(~0<<3))     //create mask for bits
    and r0,r1               //islolate bits [14:12]

    pop {lr}

    bx lr

  ENDFUNC sw_get_index

  FUNCTION sw_get_segments,global

    push {lr}

    bl gpio_c_get           //get all 32 bits of input
    lsr r0,#0               //No need to normalize
    ldr r1,=#(~(~0<<7))     //create mask for bits
    and r0,r1               //islolate bits [6:0]

    pop {lr}

    bx lr

  ENDFUNC sw_get_segments

  FUNCTION sw_get_hex,global

    push {lr}

    bl gpio_c_get           //get all 32 bits of input
    lsr r0,#7               //Normalize
    ldr r1,=#(~(~0<<4))     //create mask for bits
    and r0,r1               //islolate bits [10:7]

    pop {lr}

    bx lr

  ENDFUNC sw_get_hex

  FUNCTION sw_get_latch,global

    push {lr}

    bl gpio_c_get           //get all 32 bits of input
    lsr r0,#15              //Normalize
    ldr r1,=#(~(~0<<1))     //create mask for bits
    and r0,r1               //islolate bit [15]

    pop {lr}

    bx lr

  ENDFUNC sw_get_latch
  
  .end
