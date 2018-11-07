//Function Declarations

//# Defines
#define reload_value ?                                              /* System Timer reload value */
#define LEDs_ODR_Base        (0x????????)                         /* LEDs Port D ODR Address */

unsigned int *pLEDs = (unsigned int*)LEDs_ODR_Base;                 /* Create pointer to Port D - ODR Reg */

int main()
{
                                //set system clock    
  
                                //initialize Port D (LEDs)
  
                                //configure SysTick System Timer
  
                                //loop forever


  return 0;
}

void SysTick_Handler (void)     //ISR - SysTick Interrupt Service Routine

{    
                                //toggle Port D - LED 15
}