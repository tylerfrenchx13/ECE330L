# file: LEDR.s
# author: Justin Johnson, Tyler French
# team w4

.include "macros.inc"
.include "src/gpio_regs.inc"

  SET_TARGET

  .text

  FUNCTION LEDR_Init,global

    push {lr}

    bl gpio_d_init          //initialize GPIO port D as output

    pop {lr}

    bx lr

  ENDFUNC LEDR_Init
  
  FUNCTION LEDR_Put_A,global

    push {lr}

    mov r1,r0               //save the value of passed inputs

    bl gpio_d_get_current   //get target value
    
    mov r2,#0b1             //create 1 bit mask
    and r1,r2               //isolate new bit 8
    lsl r1,#8               //denormalize the new bit 8
    lsl r2,#8               //denormalize mask bit 8
    mvn r2,r2               //invert mask
    and r0,r2               //clear target bit 8
    orr r0,r1               //merge new bit 8 into target
    
    bl gpio_d_put           //write target register to port D

    pop {lr}

    bx lr

  ENDFUNC LEDR_Put_A

  FUNCTION LEDR_Put_B,global

    push {lr}

    mov r1,r0               //save the value of passed inputs

    bl gpio_d_get_current   //get target value

    ldr r2,=(~(~0<<4))       //create 4 bit mask
    and r1,r2               //isolate bits [5:2]
    lsl r1,#2               //denormalize the new bits
    lsl r2,#2               //denormalize mask bits
    mvn r2,r2               //invert mask
    and r0,r2               //clear target bit 2
    orr r0,r1               //merge new bits into target

    bl gpio_d_put

    pop {lr}

    bx lr

  ENDFUNC LEDR_Put_B

  FUNCTION led_put_index,global

    push {lr}

    mov r1,r0               //save the value of passed inputs

    bl gpio_d_get_current   //get target value

    ldr r2,=(~(~0<<3))       //create 4 bit mask
    and r1,r2               //isolate bits [5:2]
    lsl r1,#12               //denormalize the new bits
    lsl r2,#12               //denormalize mask bits
    mvn r2,r2               //invert mask
    and r0,r2               //clear target bit 2
    orr r0,r1               //merge new bits into target

    bl gpio_d_put

    pop {lr}

    bx lr

  ENDFUNC led_put_index

  FUNCTION led_put_segments,global

    push {lr}

    mov r1,r0               //save the value of passed inputs

    bl gpio_d_get_current   //get target value

    ldr r2,=(~(~0<<7))       //create 7 bit mask
    and r1,r2               //isolate bits [6:0]
    lsl r1,#0               //denormalize the new bits
    lsl r2,#0               //denormalize mask bits
    mvn r2,r2               //invert mask
    and r0,r2               //clear target bit 2
    orr r0,r1               //merge new bits into target

    bl gpio_d_put

    pop {lr}

    bx lr

  ENDFUNC led_put_segments
  .end
