//file: lab10.c
//authors: Justin Johnson and Tyler French
//team w4

//"#include" statements for ADC and 7 segment function prototype declarations go here
#include "adc.h"
#include "dev_adc.h"
#include "dev_gpio.h"
#include "dev_rcc.h"
#include "seg7.h"

// gpio_d_init() prototype declaration goes here!
void gpio_d_init(void);

int main(void)
{
  adc_init();                   // Initialize the ADC hardware
  seg7_init();                  // Initialize the 7 segment display
  gpio_d_init();                // Initialize the GPIO Port D as outputs (output(15-0) = off)
  uint32_t segs[] = {0x40, 0x79, 0x24, 0x30, 0x19, 0x12, 0x02, 0x78, 0x00, 0x10, 0x08, 0x03, 0x46, 0x21, 0x06, 0x0e};   // set up array of 7 segment data to display decimal digits 

  while(1) {
    uint32_t q = 0;             // Initialize any variables needed
    
    adc_start();                // Start ADC
    
    while (!adc_done()) {
      q = q +1;
                                // Wait in a tight loop for ADC conversion to finish
    }
    uint32_t val = adc_get();   // ADC is done; get ADC value (12 bits right justified)

    // Use ADC value (0 - 4095) to write 7 seg display

    // call seg7_put() for each digit in 7 segment display

    int index;      //index into segs array
    long double vRes = 3.0/4096;

    // HEX7 is always blank
    seg7_put(0x7, 0x7f);
    // HEX6 is volts
    index = (val*vRes);
    index = index%10;
    seg7_put(0x6, segs[index]);
    // HEX5 is tenths of volts
    index = ((val*vRes)*10);
    index = index%10;
    seg7_put(0x5, segs[index]);
    // HEX4 is hundredths of volts
    index = ((val*vRes)*100);
    index = index%10;
    seg7_put(0x4, segs[index]);

    // HEX3 is thousands digit of decimal ADC count
    index = (val/1000)%10;
    seg7_put(0x3, segs[index]);
    // HEX2 is hundreds digit of decimal ADC count
    index = (val/100)%10;
    seg7_put(0x2, segs[index]);
    // HEX1 is tens digit of decimal ADC count
    index = (val/10)%10;
    seg7_put(0x1, segs[index]);
    // HEX0 is ones digit of decimal ADC count
    index = val%10;
    seg7_put(0x0, segs[index]);

                                
  }

  return 0;                     // main function always returns 0 to indicate success
}
