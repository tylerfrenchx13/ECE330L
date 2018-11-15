//Function Declarations
void Systick_Handler(void);
void SetSysClock(void);
void gpio_d_init(void);
void SysTick_Config(unsigned int);

//# Defines
#include "seg7.h"
#include "adc.h"
#include "dev_adc.h"
#include "dev_gpio.h"
#include "dev_rcc.h"

//Bit abstractions
#define testbit(target,bit)                 target & (1<<bit)

#define reload_value (3362)-1        /* System Timer reload value */
#define LEDs_ODR_Base (0x40020c14)      /* LEDs Port D ODR Address */
#define SW_ODR_Base (0x40020810)    /*Swithc Port C IDR Address)*/
unsigned int *pLEDs = (unsigned int*)LEDs_ODR_Base;     /* Create pointer to Port D - ODR Reg */
unsigned int *pSWs = (unsigned int*)SW_ODR_Base;
                                                                                                                   /*M*/ /*-*/ /*l*/ /*r*/ /*u*/
uint32_t segs[] = {0x40, 0x79, 0x24, 0x30, 0x19, 0x12, 0x02, 0x78, 0x00, 0x10, 0x08, 0x03, 0x46, 0x21, 0x06, 0x0e, 0x6a, 0x3f, 0x47, 0xf7, 0x3e}; 
int count = 0;
uint32_t val = 0;
                                                                                                                  /*16*/ /*17*/
int main()
{
    adc_init();                   // Initialize the ADC hardware
    seg7_init();                  // Initialize the 7 segment display
    gpio_d_init();                        //initialize Port D (LEDs)
    gpio_c_init();
    SetSysClock();                        //set system clock    
    SysTick_Config(reload_value);         //configure SysTick System Timer
    
    while(1){
      uint32_t q = 0;             // Initialize any variables needed
      adc_start();                // Start ADC
      while (!adc_done()) {
        q = q +1;
      }
    
      val= adc_get();   // ADC is done; get ADC value (12 bits right justified)
      //val /= 4.096; // gives values 0-1000 for the adc
      //Set up Manual/Automatic Mode
      unsigned int switches = *pSWs; //manual/automatic switch
      // set up array of 7 segment data to display decimal digits [0-f,m]

      // HEX7 is always blank
      seg7_put(0x7, 0x7f);
      // HEX6 is always blank
      seg7_put(0x6, 0x7f);

      // HEX5 is Manual/Automatic Mode
      if (testbit(switches,0)){
        seg7_put(0x5, segs[16]);
      }
      else{
        seg7_put(0x5, segs[10]);
      }
      // HEX4 is hundredths of volts
      seg7_put(0x4, segs[0]);

      // HEX3 is thousands digit of decimal ADC count
      seg7_put(0x3, 0x7f);
      // HEX2 is hundreds digit of decimal ADC count
      seg7_put(0x2, segs[0]);
      // HEX1 is tens digit of decimal ADC count
      seg7_put(0x1, segs[0]);
      // HEX0 is ones digit of decimal ADC count
      seg7_put(0x0, segs[0]);
        
    }
    return 0;
}

void SysTick_Handler (void)     //ISR - SysTick Interrupt Service Routine
{   
  count %= 4096;
  //uint32_t val = adc_get();   // ADC is done; get ADC value (12 bits right justified)
  unsigned int switches = *pSWs; //manual/automatic switch

  //manual mode
  if(testbit(switches,0)){
    //arm1 (LD0)
    if(testbit(switches,1)){
      if(count<val){
        *pLEDs |= (1<<0);
      } else {
        *pLEDs &= ~(1<<0);
      }
    } 
    //arm2 (LD1)
    else {
      if(count<val){
        *pLEDs |= (1<<1);
      } else {
        *pLEDs &= ~(1<<1);
      }
    }
  } 
  //automatic mode (nothing happnes yet)
  else {

  } 
  count++;
}
