module startup;

version(GNU)
{
	static import gcc.attribute;					// we need this to get the section, weak and alias attributes
	void wfi(){ version(ALLOW_WFI){ asm{ "wfi"; } } }
}
else version(LDC)
{
	import ldc.llvmasm;
	void wfi(){ version(ALLOW_WFI){ __asm("wfi"); } }
}

import core.stdc.config;							// we need this for c_ulong, so we can get symbols from the linker-script
import core.stdc.stdint;							// these are the types normally used on microcontrollers

// Create convenience enums and aliases for the weak and alias attributes:
enum isr_vector = gcc.attribute.attribute("section",".isr_vector.ro");
enum naked = gcc.attribute.attribute("naked");
enum weak = gcc.attribute.attribute("weak");
alias Tuple(A...) = A;
alias rst = Tuple!(weak, gcc.attribute.attribute("alias", "defaultResetHandler"));
alias exc = Tuple!(weak, gcc.attribute.attribute("alias", "defaultExceptionHandler"));

// The following symbols are provided by our linker-script:
extern(C) extern __gshared c_ulong _stack;			// initial stack address
extern(C) extern __gshared c_ulong _siccmram;		// pointer to read-only data that needs to be copied to CCMRAM
extern(C) extern __gshared c_ulong _sccmram;		// start address of .ccmram section (somewhere within CCMRAM)
extern(C) extern __gshared c_ulong _eccmram;		// end address of .ccmram section (somewhere within CCMRAM)
extern(C) extern __gshared c_ulong _sirelocated;	// pointer to read-only data that needs to be copied to normal SRAM
extern(C) extern __gshared c_ulong _srelocated;		// start address of .relocated section (somewhere within SRAM)
extern(C) extern __gshared c_ulong _erelocated;		// end address of .relocated section (somewhere within SRAM)
extern(C) extern __gshared c_ulong _szeroed;		// start address of .zeroed section (somewhere within SRAM or CCMRAM)
extern(C) extern __gshared c_ulong _ezeroed;		// end address of .zeroed section (somewhere within SRAM or CCMRAM)

// Create a convenience alias for our vector functions:
//alias extern(C) const void function() VectorFunc;	// currently, this won't work for me
alias extern(C) const void *VectorFunc;				// so I'm using a void* instead.

@rst extern(C) void Reset_Handler();
@exc extern(C) void NMI_Handler();
@exc extern(C) void HardFault_Handler();
@exc extern(C) void MemManage_Handler();
@exc extern(C) void BusFault_Handler();
@exc extern(C) void UsageFault_Handler();
@exc extern(C) void SVC_Handler();
@exc extern(C) void DebugMon_Handler();
@exc extern(C) void PendSV_Handler();
@exc extern(C) void SysTick_Handler();
@exc extern(C) void WWDG_IRQHandler();
@exc extern(C) void TAMP_STAMP_IRQHandler();
@exc extern(C) void RTC_WKUP_IRQHandler();
@exc extern(C) void FLASH_IRQHandler();
@exc extern(C) void RCC_IRQHandler();
@exc extern(C) void EXTI0_IRQHandler();
@exc extern(C) void EXTI1_IRQHandler();
@exc extern(C) void EXTI2_TSC_IRQHandler();
@exc extern(C) void EXTI3_IRQHandler();
@exc extern(C) void EXTI4_IRQHandler();
@exc extern(C) void DMA1_Channel1_IRQHandler();
@exc extern(C) void DMA1_Channel2_IRQHandler();
@exc extern(C) void DMA1_Channel3_IRQHandler();
@exc extern(C) void DMA1_Channel4_IRQHandler();
@exc extern(C) void DMA1_Channel5_IRQHandler();
@exc extern(C) void DMA1_Channel6_IRQHandler();
@exc extern(C) void DMA1_Channel7_IRQHandler();
@exc extern(C) void ADC1_2_IRQHandler();
@exc extern(C) void CAN_TX_IRQHandler();
@exc extern(C) void CAN_RX0_IRQHandler();
@exc extern(C) void CAN_RX1_IRQHandler();
@exc extern(C) void CAN_SCE_IRQHandler();
@exc extern(C) void EXTI9_5_IRQHandler();
@exc extern(C) void TIM1_BRK_TIM15_IRQHandler();
@exc extern(C) void TIM1_UP_TIM16_IRQHandler();
@exc extern(C) void TIM1_TRG_COM_TIM17_IRQHandler();
@exc extern(C) void TIM1_CC_IRQHandler();
@exc extern(C) void TIM2_IRQHandler();
@exc extern(C) void TIM3_IRQHandler();
@exc extern(C) void TIM4_IRQHandler();
@exc extern(C) void I2C1_EV_IRQHandler();
@exc extern(C) void I2C1_ER_IRQHandler();
@exc extern(C) void I2C2_EV_IRQHandler();
@exc extern(C) void I2C2_ER_IRQHandler();
@exc extern(C) void SPI1_IRQHandler();
@exc extern(C) void SPI2_IRQHandler();
@exc extern(C) void USART1_IRQHandler();
@exc extern(C) void USART2_IRQHandler();
@exc extern(C) void USART3_IRQHandler();
@exc extern(C) void EXTI15_10_IRQHandler();
@exc extern(C) void RTC_Alarm_IRQHandler();
@exc extern(C) void TIM8_BRK_IRQHandler();
@exc extern(C) void TIM8_UP_IRQHandler();
@exc extern(C) void TIM8_TRG_COM_IRQHandler();
@exc extern(C) void TIM8_CC_IRQHandler();
@exc extern(C) void ADC3_IRQHandler();
@exc extern(C) void FMC_IRQHandler();
@exc extern(C) void SPI3_IRQHandler();
@exc extern(C) void UART4_IRQHandler();
@exc extern(C) void UART5_IRQHandler();
@exc extern(C) void TIM6_DAC_IRQHandler();
@exc extern(C) void TIM7_IRQHandler();
@exc extern(C) void DMA2_Channel1_IRQHandler();
@exc extern(C) void DMA2_Channel2_IRQHandler();
@exc extern(C) void DMA2_Channel3_IRQHandler();
@exc extern(C) void DMA2_Channel4_IRQHandler();
@exc extern(C) void DMA2_Channel5_IRQHandler();
@exc extern(C) void ADC4_IRQHandler();
@exc extern(C) void COMP1_2_3_IRQHandler();
@exc extern(C) void COMP4_5_6_IRQHandler();
@exc extern(C) void COMP7_IRQHandler();
@exc extern(C) void I2C3_EV_IRQHandler();
@exc extern(C) void I2C3_ER_IRQHandler();
@exc extern(C) void TIM20_BRK_IRQHandler();
@exc extern(C) void TIM20_UP_IRQHandler();
@exc extern(C) void TIM20_TRG_COM_IRQHandler();
@exc extern(C) void TIM20_CC_IRQHandler();
@exc extern(C) void FPU_IRQHandler();
@exc extern(C) void SPI4_IRQHandler();

@isr_vector VectorFunc[101] g_pfnVectors = [
	cast(VectorFunc)&_stack,														/* -16 $0000 Initial Stack Pointer */
	&Reset_Handler,																	/* -15 $0004 Reset Vector */
	&NMI_Handler,																	/* -14 $0008 Non Maskable Interrupt Vector */
	&HardFault_Handler,																/* -13 $000c Hard Fault Vector */
	&MemManage_Handler,																/* -12 $0010 Memory Protection Unit Fault Vector */
	&BusFault_Handler,																/* -11 $0014 Bus Fault Vector */
	&UsageFault_Handler,															/* -10 $0018 Usage Fault Vector */
	cast(VectorFunc)0,																/*  -9 $001c Reserved */
	cast(VectorFunc)0,																/*  -8 $0020 Reserved */
	cast(VectorFunc)0,																/*  -7 $0024 Reserved */
	cast(VectorFunc)0,																/*  -6 $0028 Reserved */
	&SVC_Handler,																	/*  -5 $002c SuperVisor Call Vector */
	&DebugMon_Handler,																/*  -4 $0030 Debug Monitor Vector */
	cast(VectorFunc)0,																/*  -3 $0034 Reserved */
	&PendSV_Handler,																/*  -2 $0038 Pending SuperVisor Vector */
	&SysTick_Handler,																/*  -1 $003c System Tick Vector */

	&WWDG_IRQHandler,																/*   0 $0040 Windowed WatchDog */
	cast(VectorFunc)0,																/*   1 $0044 Reserved */
	&TAMP_STAMP_IRQHandler,															/*   2 $0048 Tamper and TimeStamps through the EXTI line */
	&RTC_WKUP_IRQHandler,															/*   3 $004c RTC Wakeup through the EXTI line */
	&FLASH_IRQHandler,																/*   4 $0050 FLASH */
	&RCC_IRQHandler,																/*   5 $0054 RCC */
	&EXTI0_IRQHandler,																/*   6 $0058 EXTI Line0 */
	&EXTI1_IRQHandler,																/*   7 $005c EXTI Line1 */
	&EXTI2_TSC_IRQHandler,															/*   8 $0060 EXTI Line2 */
	&EXTI3_IRQHandler,																/*   9 $0064 EXTI Line3 */
	&EXTI4_IRQHandler,																/*  10 $0068 EXTI Line4 */
	&DMA1_Channel1_IRQHandler,														/*  11 $006c DMA1 Channel 1 */
	&DMA1_Channel2_IRQHandler,														/*  12 $0070 DMA1 Channel 2 */
	&DMA1_Channel3_IRQHandler,														/*  13 $0074 DMA1 Channel 3 */
	&DMA1_Channel4_IRQHandler,														/*  14 $0078 DMA1 Channel 4 */
	&DMA1_Channel5_IRQHandler,														/*  15 $007c DMA1 Channel 5 */
	&DMA1_Channel6_IRQHandler,														/*  16 $0080 DMA1 Channel 6 */
	&DMA1_Channel7_IRQHandler,														/*  17 $0084 DMA1 Channel 7 */
	&ADC1_2_IRQHandler,																/*  18 $0088 ADC1 and ADC2 */
	&CAN_TX_IRQHandler,																/*  19 $008c CAN TX */
	&CAN_RX0_IRQHandler,															/*  20 $0090 CAN RX0 */
	&CAN_RX1_IRQHandler,															/*  21 $0094 CAN RX1 */
	&CAN_SCE_IRQHandler,															/*  22 $0098 CAN SCE */
	&EXTI9_5_IRQHandler,															/*  23 $009c External Line[9:5]s */
	&TIM1_BRK_TIM15_IRQHandler,														/*  24 $00a0 TIM1 Break and TIM15 */
	&TIM1_UP_TIM16_IRQHandler,														/*  25 $00a4 TIM1 Update and TIM16 */
	&TIM1_TRG_COM_TIM17_IRQHandler,													/*  26 $00a8 TIM1 Trigger and Commutation and TIM17 */
	&TIM1_CC_IRQHandler,															/*  27 $00ac TIM1 Capture Compare */
	&TIM2_IRQHandler,																/*  28 $00b0 TIM2 */
	&TIM3_IRQHandler,																/*  29 $00b4 TIM3 */
	&TIM4_IRQHandler,																/*  30 $00b8 TIM4 */
	&I2C1_EV_IRQHandler,															/*  31 $00bc I2C1 Event */
	&I2C1_ER_IRQHandler,															/*  32 $00c0 I2C1 Error */
	&I2C2_EV_IRQHandler,															/*  33 $00c4 I2C2 Event */
	&I2C2_ER_IRQHandler,															/*  34 $00c8 I2C2 Error */
	&SPI1_IRQHandler,																/*  35 $00cc SPI1 */
	&SPI2_IRQHandler,																/*  36 $00d0 SPI2 */
	&USART1_IRQHandler,																/*  37 $00d4 USART1 */
	&USART2_IRQHandler,																/*  38 $00d8 USART2 */
	&USART3_IRQHandler,																/*  39 $00dc USART3 */
	&EXTI15_10_IRQHandler,															/*  40 $00e0 External Line[15:10]s */
	&RTC_Alarm_IRQHandler,															/*  41 $00e4 RTC Alarm (A and B) through EXTI Line */
	cast(VectorFunc)0,																/*  42 $00e8 Reserved */
	&TIM8_BRK_IRQHandler,															/*  43 $00ec TIM8 Break */
	&TIM8_UP_IRQHandler,															/*  44 $00f0 TIM8 Update */
	&TIM8_TRG_COM_IRQHandler,														/*  45 $00f4 TIM8 Trigger and Commutation */
	&TIM8_CC_IRQHandler,															/*  46 $00f8 TIM8 Capture Compare */
	&ADC3_IRQHandler,																/*  47 $00fc ADC3 */
	&FMC_IRQHandler,																/*  48 $0100 Flexible Memory Controller */
	cast(VectorFunc)0,																/*  49 $0104 Reserved */
	cast(VectorFunc)0,																/*  50 $0108 Reserved */
	&SPI3_IRQHandler,																/*  51 $010c SPI3 */
	&UART4_IRQHandler,																/*  52 $0110 UART4 */
	&UART5_IRQHandler,																/*  53 $0114 UART5 */
	&TIM6_DAC_IRQHandler,															/*  54 $0118 TIM6 and DAC */
	&TIM7_IRQHandler,																/*  55 $011c TIM7 */
	&DMA2_Channel1_IRQHandler,														/*  56 $0120 DMA2 Channel 1 */
	&DMA2_Channel2_IRQHandler,														/*  57 $0124 DMA2 Channel 2 */
	&DMA2_Channel3_IRQHandler,														/*  58 $0128 DMA2 Channel 3 */
	&DMA2_Channel4_IRQHandler,														/*  59 $012c DMA2 Channel 4 */
	&DMA2_Channel5_IRQHandler,														/*  60 $0130 DMA2 Channel 5 */
	&ADC4_IRQHandler,																/*  61 $0134 ADC4 */
	cast(VectorFunc)0,																/*  62 $0138 Reserved */
	cast(VectorFunc)0,																/*  63 $013c Reserved */
	&COMP1_2_3_IRQHandler,															/*  64 $0140 Comparator1, Comparator2 and Comparator3 */
	&COMP4_5_6_IRQHandler,															/*  65 $0144 Comparator4, Comparator5 and Comparator6 */
	&COMP7_IRQHandler,																/*  66 $0148 Comparator7 */
	cast(VectorFunc)0,																/*  67 $014c Reserved */
	cast(VectorFunc)0,																/*  68 $0150 Reserved */
	cast(VectorFunc)0,																/*  69 $0154 Reserved */
	cast(VectorFunc)0,																/*  70 $0158 Reserved */
	cast(VectorFunc)0,																/*  71 $015c Reserved */
	&I2C3_EV_IRQHandler,															/*  72 $0160 I2C3 event */
	&I2C3_ER_IRQHandler,															/*  73 $0164 I2C3 error */
	cast(VectorFunc)0,																/*  74 $0168 Reserved */
	cast(VectorFunc)0,																/*  75 $016c Reserved */
	cast(VectorFunc)0,																/*  76 $0170 Reserved */
	&TIM20_BRK_IRQHandler,															/*  77 $0174 TIM20 Break */
	&TIM20_UP_IRQHandler,															/*  78 $0178 TIM20 Update */
	&TIM20_TRG_COM_IRQHandler,														/*  79 $017c TIM20 Trigger */
	&TIM20_CC_IRQHandler,															/*  80 $0180 TIM20 Capture Compare */
	&FPU_IRQHandler,																/*  81 $0184 FPU */
	cast(VectorFunc)0,																/*  82 $0188 Reserved */
	cast(VectorFunc)0,																/*  83 $018c Reserved */
	&SPI4_IRQHandler,																/*  84 $0190 SPI4 */

	];

@weak extern(C) void LowLevelInit();
@weak extern(C) void SystemInit();
@weak extern(C) void __libc_init_array();
@weak extern(C) extern __gshared c_ulong SystemCoreClock;
extern(C) void main();

void copyBlock(const(void) *aSource, void *aDestination, void *aDestinationEnd)
{
	const(uint32_t)	*s = cast(const(uint32_t) *)aSource;
	uint32_t		*d = cast(uint32_t *)aDestination;
	uint32_t		*e = cast(uint32_t *)aDestinationEnd;

	while(d < e)
	{
		*d++ = *s++;
	}
}

void zeroBlock(void *aDestination, void *aDestinationEnd)
{
	uint32_t	*d = cast(uint32_t *)aDestination;
	uint32_t	*e = cast(uint32_t *)aDestinationEnd;

	while(d < e)
	{
		*d++ = 0;
	}
}

@naked extern(C) void defaultResetHandler()											/* we can mark this naked, as it never returns and should never save any registers on the stack */
{
	uint32_t	saveFreq;

	LowLevelInit();
	SystemInit();

	saveFreq = SystemCoreClock;
	copyBlock(&_siccmram, &_sccmram, &_eccmram);
	copyBlock(&_sirelocated, &_srelocated, &_erelocated);
	zeroBlock(&_szeroed, &_ezeroed);
	__libc_init_array();
	if(&SystemCoreClock) SystemCoreClock = saveFreq;

	main();
	defaultExceptionHandler();
}

@naked extern(C) void defaultExceptionHandler()
{
	while(true)
	{
		wfi();
	}
}
