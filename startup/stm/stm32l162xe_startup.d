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

BootRAM = 0xF108F85F;

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
@exc extern(C) void PVD_IRQHandler();
@exc extern(C) void TAMPER_STAMP_IRQHandler();
@exc extern(C) void RTC_WKUP_IRQHandler();
@exc extern(C) void FLASH_IRQHandler();
@exc extern(C) void RCC_IRQHandler();
@exc extern(C) void EXTI0_IRQHandler();
@exc extern(C) void EXTI1_IRQHandler();
@exc extern(C) void EXTI2_IRQHandler();
@exc extern(C) void EXTI3_IRQHandler();
@exc extern(C) void EXTI4_IRQHandler();
@exc extern(C) void DMA1_Channel1_IRQHandler();
@exc extern(C) void DMA1_Channel2_IRQHandler();
@exc extern(C) void DMA1_Channel3_IRQHandler();
@exc extern(C) void DMA1_Channel4_IRQHandler();
@exc extern(C) void DMA1_Channel5_IRQHandler();
@exc extern(C) void DMA1_Channel6_IRQHandler();
@exc extern(C) void DMA1_Channel7_IRQHandler();
@exc extern(C) void ADC1_IRQHandler();
@exc extern(C) void USB_HP_IRQHandler();
@exc extern(C) void USB_LP_IRQHandler();
@exc extern(C) void DAC_IRQHandler();
@exc extern(C) void COMP_IRQHandler();
@exc extern(C) void EXTI9_5_IRQHandler();
@exc extern(C) void LCD_IRQHandler();
@exc extern(C) void TIM9_IRQHandler();
@exc extern(C) void TIM10_IRQHandler();
@exc extern(C) void TIM11_IRQHandler();
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
@exc extern(C) void USB_FS_WKUP_IRQHandler();
@exc extern(C) void TIM6_IRQHandler();
@exc extern(C) void TIM7_IRQHandler();
@exc extern(C) void TIM5_IRQHandler();
@exc extern(C) void SPI3_IRQHandler();
@exc extern(C) void UART4_IRQHandler();
@exc extern(C) void UART5_IRQHandler();
@exc extern(C) void DMA2_Channel1_IRQHandler();
@exc extern(C) void DMA2_Channel2_IRQHandler();
@exc extern(C) void DMA2_Channel3_IRQHandler();
@exc extern(C) void DMA2_Channel4_IRQHandler();
@exc extern(C) void DMA2_Channel5_IRQHandler();
@exc extern(C) void AES_IRQHandler();
@exc extern(C) void COMP_ACQ_IRQHandler();

@isr_vector VectorFunc[79] g_pfnVectors = [
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
	&PVD_IRQHandler,																/*   1 $0044 PVD through EXTI Line detection */
	&TAMPER_STAMP_IRQHandler,														/*   2 $0048 TAMPER STAMP */
	&RTC_WKUP_IRQHandler,															/*   3 $004c RTC Wakeup through the EXTI line */
	&FLASH_IRQHandler,																/*   4 $0050 FLASH */
	&RCC_IRQHandler,																/*   5 $0054 Reset and Clock Configuration */
	&EXTI0_IRQHandler,																/*   6 $0058 External Interrupt Line 0 */
	&EXTI1_IRQHandler,																/*   7 $005c External Interrupt Line 1 */
	&EXTI2_IRQHandler,																/*   8 $0060 External Interrupt Line 2 */
	&EXTI3_IRQHandler,																/*   9 $0064 External Interrupt Line 3 */
	&EXTI4_IRQHandler,																/*  10 $0068 EXTI Line4 */
	&DMA1_Channel1_IRQHandler,														/*  11 $006c DMA1 Channel 1 */
	&DMA1_Channel2_IRQHandler,														/*  12 $0070 DMA1 Channel 2 */
	&DMA1_Channel3_IRQHandler,														/*  13 $0074 DMA1 Channel 3 */
	&DMA1_Channel4_IRQHandler,														/*  14 $0078 DMA1 Channel 4 */
	&DMA1_Channel5_IRQHandler,														/*  15 $007c DMA1 Channel 5 */
	&DMA1_Channel6_IRQHandler,														/*  16 $0080 DMA1 Channel 6 */
	&DMA1_Channel7_IRQHandler,														/*  17 $0084 DMA1 Channel 7 */
	&ADC1_IRQHandler,																/*  18 $0088 ADC1 */
	&USB_HP_IRQHandler,																/*  19 $008c USB High Priority */
	&USB_LP_IRQHandler,																/*  20 $0090 USB Low Priority */
	&DAC_IRQHandler,																/*  21 $0094 DAC */
	&COMP_IRQHandler,																/*  22 $0098 COMP */
	&EXTI9_5_IRQHandler,															/*  23 $009c External Line[9:5]s */
	&LCD_IRQHandler,																/*  24 $00a0 LCD */
	&TIM9_IRQHandler,																/*  25 $00a4 TIM9 */
	&TIM10_IRQHandler,																/*  26 $00a8 TIM10 */
	&TIM11_IRQHandler,																/*  27 $00ac TIM11 */
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
	&EXTI15_10_IRQHandler,															/*  40 $00e0 External Interrupt Lines[15:10] */
	&RTC_Alarm_IRQHandler,															/*  41 $00e4 RTC Alarm (A and B) through EXTI Line */
	&USB_FS_WKUP_IRQHandler,														/*  42 $00e8 USB FS WKUP */
	&TIM6_IRQHandler,																/*  43 $00ec TIM6 */
	&TIM7_IRQHandler,																/*  44 $00f0 TIM7 */
	cast(VectorFunc)0,																/*  45 $00f4 Reserved */
	&TIM5_IRQHandler,																/*  46 $00f8 TIM5 */
	&SPI3_IRQHandler,																/*  47 $00fc SPI3 */
	&UART4_IRQHandler,																/*  48 $0100 UART4 */
	&UART5_IRQHandler,																/*  49 $0104 UART5 */
	&DMA2_Channel1_IRQHandler,														/*  50 $0108 DMA2 Channel 1 */
	&DMA2_Channel2_IRQHandler,														/*  51 $010c DMA2 Channel 2 */
	&DMA2_Channel3_IRQHandler,														/*  52 $0110 DMA2 Channel 3 */
	&DMA2_Channel4_IRQHandler,														/*  53 $0114 DMA2 Channel 4 */
	&DMA2_Channel5_IRQHandler,														/*  54 $0118 DMA2 Channel 5 */
	&AES_IRQHandler,																/*  55 $011c AES */
	&COMP_ACQ_IRQHandler,															/*  56 $0120 COMP ACQ */
	cast(VectorFunc)0,																/*  57 $0124 Reserved */
	cast(VectorFunc)0,																/*  58 $0128 Reserved */
	cast(VectorFunc)0,																/*  59 $012c Reserved */
	cast(VectorFunc)0,																/*  60 $0130 Reserved */
	cast(VectorFunc)0,																/*  61 $0134 Reserved */
	cast(VectorFunc)BootRAM,														/*  62 $0138  */
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
