#include "water.h"

#define NVIC_BASE             (SCS_BASE +  0x0100UL)
#define SYSCFG_BASE           (APB2PERIPH_BASE + 0x3800)
#define EXTI_BASE             (APB2PERIPH_BASE + 0x3C00)

#define RCC_CR_HSEON        ((uint32_t)0x00010000)
#define RCC_CR_HSERDY       ((uint32_t)0x00020000)
#define RCC_CR_PLLON        ((uint32_t)0x01000000)
#define RCC_CR_PLLRDY       ((uint32_t)0x02000000)
#define RCC_CFGR_SW         ((uint32_t)0x00000003)        /*!< SW[1:0] bits (System clock Switch) */
#define RCC_CFGR_SW_PLL     ((uint32_t)0x00000002)        /*!< PLL selected as system clock */
#define RCC_CFGR_SWS        ((uint32_t)0x0000000C)        /*!< SWS[1:0] bits (System Clock Switch Status) */
#define RCC_CFGR_SWS_PLL    ((uint32_t)0x00000008)        /*!< PLL used as system clock */
#define RCC_CFGR_HPRE_DIV1  ((uint32_t)0x00000000)        /*!< SYSCLK not divided */
#define RCC_CFGR_HPRE_DIV2  ((uint32_t)0x00000080)        /*!< SYSCLK divided by 2 */
#define RCC_CFGR_HPRE_DIV4  ((uint32_t)0x00000090)        /*!< SYSCLK divided by 4 */
#define RCC_CFGR_PPRE1_DIV4 ((uint32_t)0x00001400)        /*!< HCLK divided by 4 */
#define RCC_CFGR_PPRE2_DIV2 ((uint32_t)0x00008000)        /*!< HCLK divided by 2 */
#define RCC_CFGR_PPRE2_DIV4 ((uint32_t)0x0000A000)        /*!< HCLK divided by 4 */
#define RCC_PLLCFGR_PLLSRC_HSE              ((uint32_t)0x00400000)
#define RCC_APB1ENR_PWREN   ((uint32_t)0x10000000)

#define PWR_CR_VOS          ((uint16_t)0x4000)     /*!< Regulator voltage scaling output selection */
#define PWR_CR_PMODE        PWR_CR_VOS

#define FLASH_ACR_LATENCY_5WS	((uint32_t)0x00000005)
#define FLASH_ACR_ICEN		((uint32_t)0x00000200)
#define FLASH_ACR_DCEN		((uint32_t)0x00000400)

#define HSE_STARTUP_TIMEOUT	((uint16_t)0x0500)	/*!< Time out for HSE start up */

/*!< Uncomment the following line if you need to relocate your vector Table in
     Internal SRAM. */
/* #define VECT_TAB_SRAM */
#define VECT_TAB_OFFSET		0x00 /*!< Vector Table base offset field. 
				      This value must be a multiple of 0x200. */


/* PLL_VCO = (HSE_VALUE or HSI_VALUE / PLL_M) * PLL_N */
#define PLL_M      8
#define PLL_N      336

/* SYSCLK = PLL_VCO / PLL_P */
#define PLL_P      2

/* USB OTG FS, SDIO and RNG Clock =  PLL_VCO / PLLQ */
#define PLL_Q      7

struct RCC_t		*RCC		= (struct RCC_t  *) RCC_BASE;
struct SCB_t		*SCB		= (struct SCB_t  *) SCB_BASE;
struct PWR_t		*PWR		= (struct PWR_t  *) PWR_BASE;
struct FLASH_t		*FLASH		= (struct FLASH_t*) FLASH_R_BASE;
struct SysTick_t	*SysTick	= (struct SysTick_t*)SysTick_BASE;

static struct NVIC_t	*NVIC		= (struct NVIC_t  *)NVIC_BASE;
static struct SYSCFG_t	*SYSCFG		= (struct SYSCFG_t*)SYSCFG_BASE;
static struct EXTI_t	*EXTI		= (struct EXTI_t  *)EXTI_BASE;

uint32_t SystemCoreClock = 168000000;

__I uint8_t AHBPrescTable[16] = {0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 6, 7, 8, 9};

static void SetSysClock(void);

void SystemInit(void)
{
  /* Reset the RCC clock configuration to the default reset state ------------*/
  /* Set HSION bit */
  RCC->CR |= (uint32_t)0x00000001;

  /* Reset CFGR register */
  RCC->CFGR = 0x00000000;

  /* Reset HSEON, CSSON and PLLON bits */
  RCC->CR &= (uint32_t)0xFEF6FFFF;

  /* Reset PLLCFGR register */
  RCC->PLLCFGR = 0x24003010;

  /* Reset HSEBYP bit */
  RCC->CR &= (uint32_t)0xFFFBFFFF;

  /* Disable all interrupts */
  RCC->CIR = 0x00000000;

  //#ifdef DATA_IN_ExtSRAM
  //  SystemInit_ExtMemCtl(); 
  //#endif /* DATA_IN_ExtSRAM */
         
  /* Configure the System clock source, PLL Multiplier and Divider factors, 
     AHB/APBx prescalers and Flash settings ----------------------------------*/
  SetSysClock();

  /* Configure the Vector Table location add offset address ------------------*/

  SCB->VTOR = FLASH_BASE | VECT_TAB_OFFSET; /* Vector Table Relocation in Internal FLASH */
}

static void SetSysClock(void)
{
  /******************************************************************************/
  /*            PLL (clocked by HSE) used as System clock source                */
  /******************************************************************************/
  __IO uint32_t StartUpCounter = 0, HSEStatus = 0;
  
  /* Enable HSE */
  RCC->CR |= ((uint32_t)RCC_CR_HSEON);
 
  /* Wait till HSE is ready and if Time out is reached exit */
  do
  {
    HSEStatus = RCC->CR & RCC_CR_HSERDY;
    StartUpCounter++;
  } while((HSEStatus == 0) && (StartUpCounter != HSE_STARTUP_TIMEOUT));

  if ((RCC->CR & RCC_CR_HSERDY) != RESET)
  {
    HSEStatus = (uint32_t)0x01;
  }
  else
  {
    HSEStatus = (uint32_t)0x00;
  }

  if (HSEStatus == (uint32_t)0x01)
  {
    /* Enable high performance mode, System frequency up to 168 MHz */
    RCC->APB1ENR |= RCC_APB1ENR_PWREN;
    PWR->CR |= PWR_CR_PMODE;  

    /* HCLK = SYSCLK / 1*/
    RCC->CFGR |= RCC_CFGR_HPRE_DIV1;
      
    /* PCLK2 = HCLK / 2*/
    RCC->CFGR |= RCC_CFGR_PPRE2_DIV2;
    
    /* PCLK1 = HCLK / 4*/
    RCC->CFGR |= RCC_CFGR_PPRE1_DIV4;

    /* Configure the main PLL */
    RCC->PLLCFGR = PLL_M | (PLL_N << 6) | (((PLL_P >> 1) -1) << 16) |
                   (RCC_PLLCFGR_PLLSRC_HSE) | (PLL_Q << 24);

    /* Enable the main PLL */
    RCC->CR |= RCC_CR_PLLON;

    /* Wait till the main PLL is ready */
    while((RCC->CR & RCC_CR_PLLRDY) == 0)
    {
    }
   
    /* Configure Flash prefetch, Instruction cache, Data cache and wait state */
    FLASH->ACR = FLASH_ACR_ICEN |FLASH_ACR_DCEN |FLASH_ACR_LATENCY_5WS;

    /* Select the main PLL as system clock source */
    RCC->CFGR &= (uint32_t)((uint32_t)~(RCC_CFGR_SW));
    RCC->CFGR |= RCC_CFGR_SW_PLL;

    /* Wait till the main PLL is used as system clock source */
    while ((RCC->CFGR & (uint32_t)RCC_CFGR_SWS ) != RCC_CFGR_SWS_PLL);
    {
    }
  }
  else
  { /* If HSE fails to start-up, the application will have wrong clock
         configuration. User can add here some code to deal with this error */
  }
}


void NVIC_SetPriority(uint32_t IRQn, uint32_t priority)
{
  if(IRQn < 0)
    {
      /* set Priority for Cortex-M  System Interrupts */
      SCB->SHP[((uint32_t)(IRQn) & 0xF)-4] = ((priority << (8 - __NVIC_PRIO_BITS)) & 0xff);
    } 
  else
    {
      /* set Priority for device specific Interrupts  */
      NVIC->IP[(uint32_t)(IRQn)] = ((priority << (8 - __NVIC_PRIO_BITS)) & 0xff);
    }
}

uint32_t SysTick_Config(uint32_t ticks)
{
  if (ticks > SysTick_LOAD_RELOAD_Msk)  return (1);            /* Reload value impossible */

  SysTick->LOAD  = (ticks & SysTick_LOAD_RELOAD_Msk) - 1;      /* set reload register */
  NVIC_SetPriority (SysTick_IRQn, (1<<__NVIC_PRIO_BITS) - 1);  /* set Priority for Cortex-M0 System Interrupts */
  SysTick->VAL   = 0;                                          /* Load the SysTick Counter Value */
  SysTick->CTRL  = SysTick_CTRL_CLKSOURCE_Msk |
                   SysTick_CTRL_TICKINT_Msk   |
                   SysTick_CTRL_ENABLE_Msk;                    /* Enable SysTick IRQ and SysTick Timer */
  return (0);                                                  /* Function successful */
}
