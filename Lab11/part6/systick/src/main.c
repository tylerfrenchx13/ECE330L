//Function Declarations
void Systick_Handler(void);
void SetSysClock(void);
void gpio_d_init(void);
void SysTick_Config(unsigned int);

//# Defines
#define reload_value (1<<24)-1        /* System Timer reload value */
#define LEDs_ODR_Base (0x40020c14)      /* LEDs Port D ODR Address */

unsigned int *pLEDs = (unsigned int*)LEDs_ODR_Base;     /* Create pointer to Port D - ODR Reg */
int count = 0;

int main()
{
    SetSysClock();                        //set system clock    
  
    gpio_d_init();                        //initialize Port D (LEDs)
  
    SysTick_Config(reload_value);         //configure SysTick System Timer
  
  do { 
    
  } while (1);                          //loop forever

  return 0;
}

void SysTick_Handler (void)     //ISR - SysTick Interrupt Service Routine
{   
    if (count > 15) {
        count = 0;
        *pLEDs &= 0;
    }
    
    *pLEDs |= (1<<count); 

    count++;    
}
