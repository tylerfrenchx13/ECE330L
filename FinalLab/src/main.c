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
                                                                                                                   /*M*/ /*-*/ /*l*/ /*r*/ /*u*/ /* */ /*V*/ /*H*/
uint32_t segs[] = {0x40, 0x79, 0x24, 0x30, 0x19, 0x12, 0x02, 0x78, 0x00, 0x10, 0x08, 0x03, 0x46, 0x21, 0x06, 0x0e, 0x6a, 0x3f, 0x47, 0xf7, 0x3e, 0x7f, 0x41, 0x09}; 
                                                                                                                  /*16*/ /*17*/                  /*21*//*22*//*23*/
int count = 0;
int cnt = 0;
int hold1 = 0;
int hold2 = 0;
int arm;
int degv;
int degh;
int auto_inc=0;
uint32_t val = 0;
int sw = 0;
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
        q = q + 1;
      }
    
      val = adc_get();   // ADC is done; get ADC value (12 bits right justified)
      val = (val/23) + 180;

      //Set up Manual/Automatic Mode
      unsigned int switches = *pSWs; //manual/automatic switch
      // set up array of 7 segment data to display decimal digits [0-f,m]

      // HEX7 is always blank
      seg7_put(0x7, segs[21]);
      // HEX6 is always blank
      seg7_put(0x6, segs[21]);

      // HEX5 is Manual/Automatic Mode
      if (testbit(switches,0)){
        seg7_put(0x5, segs[16]);
      }
      else{
        seg7_put(0x5, segs[10]);
      }
      //Up down left or right TODO Both
      seg7_put(0x4, segs[arm]);

      int index;
      //degrees 10th place
      index = (degv/10)%10;
      seg7_put(0x3, segs[index]);
      //degrees 1's place
      index = (degv%10);
      seg7_put(0x2, segs[index]);
      //degrees 10th place
      index = (degh/10)%10;
      seg7_put(0x1, segs[index]);
      //degrees 1's place
      index = degh%10;
      seg7_put(0x0, segs[index]);
        
    }
    return 0;
}

void SysTick_Handler (void)     //ISR - SysTick Interrupt Service Routine
{   

  unsigned int switches = *pSWs; //manual/automatic switch

  //manual mode
  if(testbit(switches,0)){
    count %= 3600;
    //arm1 (LD0) -- left/right
    if(testbit(switches,1)){
      arm=23;
      hold1 = val;
      if(count<val){
        *pLEDs |= (1<<0);
      } else {
        *pLEDs &= ~(1<<0);
      }

      if(count<hold2){
        *pLEDs |= (1<<1);
      } else {
        *pLEDs &= ~(1<<1);
      }
      degh = val - 270;
      if(degh<0) degh *= -1;
    } 
    //arm2 (LD1) -- up/down
    else {
      arm=22;
      hold2 = val;
      if(count<val){
        *pLEDs |= (1<<1);
      } else {
        *pLEDs &= ~(1<<1);
      }

      if(count<hold1){
        *pLEDs |= (1<<0);
      } else {
        *pLEDs &= ~(1<<0);
      }
      degv = val -270;
      if(degv<0) degv *= -1;
    }
  } 
  //automatic mode
  else {
    auto_inc = (auto_inc % 180) + 180;
    count %= 3600;
    cnt %= 50000;
    //arm1 (LD0) -- left/right
    arm=11;
    if(count<auto_inc){
      *pLEDs |= (1<<0);
    } else {
      *pLEDs &= ~(1<<0);
    }

    degh = auto_inc - 270;
    if(degh<0) degh *= -1;

    //arm2 (LD1) -- up/down
    if(count<auto_inc){
      *pLEDs |= (1<<1);
    } else {
      *pLEDs &= ~(1<<1);
    }

    degv = auto_inc - 270;
    if(degv<0) degv *= -1;

    if(auto_inc == 360) sw=1;
    else if(auto_inc == 180) sw=0;
  
    if (cnt%50000 == 0) {
      if (sw == 1)
        auto_inc--;
      else 
        auto_inc++;
    }
  } 
  count++;
  cnt++;
}
