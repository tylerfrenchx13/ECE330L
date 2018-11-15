
#define SysTick_BASE        (0xE000E010)                            /*!< SysTick Base Address  */

struct SysTick_t	*SysTick	= (struct SysTick_t*)SysTick_BASE; /*!< SysTick Struct Pointer  */

struct SysTick_t
{
    /*!< Offset: 0x000 (R/W)  SysTick Control and Status Register */
    unsigned int SYST_CSR;
    /*!< Offset: 0x004 (R/W)  SysTick Reload Value Register       */
    unsigned int SYST_RVR;
    /*!< Offset: 0x008 (R/W)  SysTick Current Value Register      */
    unsigned int SYST_CVR;
    /*!< Offset: 0x00C (R/ )  SysTick Calibration Register        */
    unsigned int SYST_CALIB;
};


unsigned int SysTick_Config(unsigned int ticks)
{
    /* set reload register */
    if (ticks > ((1<<24)-1)) {
        ticks = 1<<24;
    }
    ticks /=65;
    SysTick->SYST_RVR = ticks;       /* set reload register - don't allow bigger than 2^24-1! */

    SysTick->SYST_CVR = 0;       /* Load the SysTick Counter Value */
  
    //CLKSOURCE: SYST_CSR + 2   //Clock Source is Processor Clock
    unsigned int *clksrc = (unsigned int*)SysTick_BASE + 2;     /* Create pointer to Port D - ODR Reg */
    //TICKINT: SYST_CST + 1     //Enable SysTick IRQ
    unsigned int *tickint = (unsigned int*)SysTick_BASE + 1; 
    //ENABLE: SYST_CST + 0      //Enable SysTick Timer Count
    unsigned int *enable = (unsigned int*)SysTick_BASE;  
    SysTick->SYST_CSR = (*clksrc | *tickint | *enable);
   
    return (0);                           /* Function successful but we won't check */                          
}
