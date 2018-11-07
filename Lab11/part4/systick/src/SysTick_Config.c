

#define SysTick_BASE        (0x????????)                            /*!< SysTick Base Address  */

struct SysTick_t	*SysTick	= (struct SysTick_t*)SysTick_BASE; /*!< SysTick Struct Pointer  */

struct SysTick_t
{
  /*!< Offset: 0x000 (R/W)  SysTick Control and Status Register */
  /*!< Offset: 0x004 (R/W)  SysTick Reload Value Register       */
  /*!< Offset: 0x008 (R/W)  SysTick Current Value Register      */
  /*!< Offset: 0x00C (R/ )  SysTick Calibration Register        */
};


unsigned int SysTick_Config(unsigned int ticks)
{
  
/* set reload register */ 
  SysTick->LOAD  = /* set reload register - don't allow bigger than 2^24-1! */

  SysTick->VAL   = /* Load the SysTick Counter Value */
  
  SysTick->CTRL  = /* Clock source is processor clock, Enable SysTick IRQ, and enable SysTick Timer Counter */
   
  return (0);                           /* Function successful but we won't check */                          
}
