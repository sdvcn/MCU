	Reset_Handler,					/* Reset Vector */
	NMI_Handler,					/* Non Maskable Interrupt Vector */
	HardFault_Handler,				/* Hard Fault Vector */
	MemManage_Handler,				/* Memory Protection Unit Fault Vector */
	BusFault_Handler,				/* Bus Fault Vector */
	UsageFault_Handler,				/* Usage Fault Vector */
	,								/* Reserved */
	,								/* Reserved */
	,								/* Reserved */
	,								/* Reserved */
	SVC_Handler,					/* SuperVisor Call Vector */
	DebugMon_Handler,				/* Debug Monitor Vector */
	,								/* Reserved */
	PendSV_Handler,					/* Pending SuperVisor Vector */
	SysTick_Handler,				/* System Tick Vector */

	WWDG_IRQHandler,				/* Windowed WatchDog */
	PVD_IRQHandler,					/* PVD through EXTI Line detection */
	TAMPER_IRQHandler,				/* Tamper */
	RTC_IRQHandler,					/* Real Time Clock */
	FLASH_IRQHandler,				/* FLASH */
	RCC_IRQHandler,					/* Reset and Clock Configuration */
	EXTI0_IRQHandler,				/* External Interrupt Line 0 */
	EXTI1_IRQHandler,				/* External Interrupt Line 1 */
	EXTI2_IRQHandler,				/* External Interrupt Line 2 */
	EXTI3_IRQHandler,				/* External Interrupt Line 3 */
	EXTI4_IRQHandler,				/* EXTI Line4 */
	DMA1_Channel1_IRQHandler,		/* DMA1 Channel 1 */
	DMA1_Channel2_IRQHandler,		/* DMA1 Channel 2 */
	DMA1_Channel3_IRQHandler,		/* DMA1 Channel 3 */
	DMA1_Channel4_IRQHandler,		/* DMA1 Channel 4 */
	DMA1_Channel5_IRQHandler,		/* DMA1 Channel 5 */
	DMA1_Channel6_IRQHandler,		/* DMA1 Channel 6 */
	DMA1_Channel7_IRQHandler,		/* DMA1 Channel 7 */
	ADC1_IRQHandler,				/* ADC1 */
	USB_HP_IRQHandler,				/* USB High Priority */
	USB_LP_IRQHandler,				/* USB Low Priority */
	,								/* Reserved */
	,								/* Reserved */
	EXTI9_5_IRQHandler,				/* External Line[9:5]s */
	,								/* Reserved */
	,								/* Reserved */
	,								/* Reserved */
	,								/* Reserved */
	TIM2_IRQHandler,				/* TIM2 */
	TIM3_IRQHandler,				/* TIM3 */
	,								/* Reserved */
	I2C1_EV_IRQHandler,				/* I2C1 Event */
	I2C1_ER_IRQHandler,				/* I2C1 Error */
	,								/* Reserved */
	,								/* Reserved */
	SPI1_IRQHandler,				/* SPI1 */
	,								/* Reserved */
	USART1_IRQHandler,				/* USART1 */
	USART2_IRQHandler,				/* USART2 */
	,								/* Reserved */
	EXTI15_10_IRQHandler,			/* External Interrupt Lines[15:10] */
	RTC_Alarm_IRQHandler,			/* RTC Alarm (A and B) through EXTI Line */
	USBWakeUp_IRQHandler,			/* USB Wake Up */
	,								/* Reserved */
	,								/* Reserved */
	,								/* Reserved */
	,								/* Reserved */
	,								/* Reserved */
	,								/* Reserved */
	,								/* Reserved */
	BootRAM = 0xF108F85F,			/* This is for boot in RAM mode for STM32F10x Connectivity line Devices */
