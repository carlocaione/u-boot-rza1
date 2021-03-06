/*
 * Copyright (C) 2008-2013 Renesas Solutions Corp.
 * Copyright (C) 2012 Renesas Electronics Europe Ltd.
 * Copyright (C) 2012 Phil Edworthy
 * Copyright (C) 2008 Nobuhiro Iwamatsu
 *
 * Based on board/renesas/rsk7264/lowlevel_init.S
 *
 * This file is released under the terms of GPL v2 and any later version.
 * See the file COPYING in the root directory of the source tree for details.
 */
#include <config.h>
#include <version.h>
#include <asm/arch/rza1-regs.h>
#include <asm/macro.h>

	.global	lowlevel_init

	.text
	.align	2

lowlevel_init:
	/* PL310 init */
	write32 0x3fffff80, 0x00000001

	/* Disable WDT */
	write16	WTCSR, WTCSR_D
	write16	WTCNT, WTCNT_D

	/* Disable Register Bank interrupts */
	/* write16 IBNR, IBNR_D */

	/* Set clocks */
	write16	FRQCR, FRQCR_D

	/* Enable all peripherals(Standby Control) */
	write8 STBCR3, STBCR3_D
	write8 STBCR4, STBCR4_D
	write8 STBCR5, STBCR5_D
	write8 STBCR6, STBCR6_D
	write8 STBCR7, STBCR7_D
	write8 STBCR8, STBCR8_D
	write8 STBCR9, STBCR9_D
	write8 STBCR10, STBCR10_D
	write8 STBCR11, STBCR11_D
	write8 STBCR12, STBCR12_D

	/* Port Control Register */
	write16 PIBC1, PIBC1_D
	write16 PBDC1, PBDC1_D
	write16 PM1, PM1_D
	write16 PMC1, PMC1_D
	write16 PIPC1, PIPC1_D

	write16 PBDC1, PBDC1_S
	write16 PFC1, PFC1_D
	write16 PFCE1, PFCE1_D
	write16 PFCAE1, PFCAE1_D
	write16 PIPC1, PIPC1_S
	write16 PMC1, PMC1_S
	
	write16 PMC2, PMC2_D
	write16 PFC2, PFC2_D
	write16 PFCE2, PFCE2_D
	write16 PFCAE2, PFCAE2_D
	write16 PIPC2, PIPC2_D
	write16 PM2, PM2_D
	write16 PMC3, PMC3_D
	write16 PFC3, PFC3_D
	write16 PFCE3, PFCE3_D
	write16 PFCAE3, PFCAE3_D
	write16 PIPC3, PIPC3_D
	write16 PM3, PM3_D
	write16 PMC5, PMC5_D
	write16 PFC5, PFC5_D
	write16 PFCE5, PFCE5_D
	write16 PFCAE5, PFCAE5_D
	write16 PM5, PM5_D
	write16 PMC6, PMC6_D
	write16 PIPC6, PIPC6_D
	write16 PMC7, PMC7_D
	write16 PFC7, PFC7_D
	write16 PFCE7, PFCE7_D
	write16 PFCAE7, PFCAE7_D
	write16 PIPC7, PIPC7_D
	write16 PM7, PM7_D
	write16 PMC8, PMC8_D
	write16 PFC8, PFC8_D
	write16 PFCE8, PFCE8_D
	write16 PFCAE8, PFCAE8_D
	write16 PIPC8, PIPC8_D
	write16 PM8, PM8_D
	write16 PMC9, PMC9_D
	write16 PFC9, PFC9_D
	write16 PFCE9, PFCE9_D
	write16 PFCAE9, PFCAE9_D
	write16 PIPC9, PIPC9_D
	write16 PM9, PM9_D

	/* Configure bus (CS0, CS1) */
	write32 CS0WCR, CS0WCR_D
	write32 CS0BCR, CS0BCR_D
	write32 CS1WCR, CS1WCR_D
	write32 CS1BCR, CS1BCR_D

	/* Configure SDRAM (CS2, CS3) */
	write32	CS2BCR, CS2BCR_D
	write32	CS2WCR, CS2WCR_D
	write32	CS3BCR, CS3BCR_D
	write32	CS3WCR, CS3WCR_D
	write32	SDCR, SDCR_D
	write32	RTCOR, RTCOR_D
	write32	RTCSR, RTCSR_D

	/* wait */
	ldr	r3, REPEAT_D
	mov	r2, #0
repeat0:
	add	r2, r2, #1
	cmp	r2, r3
	ble	repeat0
	nop

	ldr	r1, SDRAM_MODE_CS2
	mov	r0, #0
	str	r0, [r1]
	ldr	r1, SDRAM_MODE_CS3
	mov	r0, #0
	str	r0, [r1]

	nop
	/* back to arch calling code */
	mov	pc, lr

	.align 4

.align 2
SDRAM_MODE_CS2:	.long 0x3FFFD040
SDRAM_MODE_CS3:	.long 0x3FFFE040
REPEAT_D:	.long 0x000033F1
