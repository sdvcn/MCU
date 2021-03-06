	Reset_Handler,							/* Reset Vector */
	NMI_Handler,							/* Non Maskable Interrupt Vector */
	HardFault_Handler,						/* Hard Fault Vector */
	,										/* Reserved */
	,										/* Reserved */
	,										/* Reserved */
	,										/* Reserved */
	,										/* Reserved */
	,										/* Reserved */
	,										/* Reserved */
	SVC_Handler,							/* SuperVisor Call Vector */
	,										/* Reserved */
	,										/* Reserved */
	PendSV_Handler,							/* Pending SuperVisor Vector */
	SysTick_Handler,						/* System Tick Vector */

	PIN_INT0_IRQHandler,					/* Pin Interrupt 0 */
	PIN_INT1_IRQHandler,					/* Pin Interrupt 1 */
	PIN_INT2_IRQHandler,					/* Pin Interrupt 2 */
	PIN_INT3_IRQHandler,					/* Pin Interrupt 3 */
	PIN_INT4_IRQHandler,					/* Pin Interrupt 4 */
	PIN_INT5_IRQHandler,					/* Pin Interrupt 5 */
	PIN_INT6_IRQHandler,					/* Pin Interrupt 6 */
	PIN_INT7_IRQHandler,					/* Pin Interrupt 7 */
	GINT0_IRQHandler,						/* GPIO GROUP 0 interrupt */
	GINT1_IRQHandler,						/* GPIO GROUP 1 interrupt */
	Reserved10_IRQHandler,					/* Reserved Interrupt */
	Reserved11_IRQHandler,					/*  */
	Reserved12_IRQHandler,					/*  */
	Reserved13_IRQHandler,					/*  */
	SSP1_IRQHandler,						/* SSP1 Interrupt */
	I2C0_IRQHandler,						/* I2C Interrupt */
	TIMER_16_0_IRQHandler,					/* 16-bit Timer0 Interrupt */
	TIMER_16_1_IRQHandler,					/* 16-bit Timer1 Interrupt */
	TIMER_32_0_IRQHandler,					/* 32-bit Timer0 Interrupt */
	TIMER_32_1_IRQHandler,					/* 32-bit Timer1 Interrupt */
	SSP0_IRQHandler,						/* SSP0 Interrupt */
	UART0_IRQHandler,						/* UART Interrupt */
	Reserved22_IRQHandler,					/*  */
	Reserved23_IRQHandler,					/*  */
	ADC_IRQHandler,							/* A/D Converter Interrupt */
	WDT_IRQHandler,							/* Watchdog timer Interrupt */
	BOD_IRQHandler,							/* Brown Out Detect(BOD) Interrupt */
	FMC_IRQHandler,							/* Flash Memory Controller Interrupt */
	RESERVED28_IRQHandler,					/*  */
	RESERVED29_IRQHandler,					/*  */
	RESERVED30_IRQHandler,					/*  */
	RESERVED31_IRQHandler,					/*  */
