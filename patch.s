	CPU 90C141
	ORG 00000H

INTERNAL_ROM_START = 00000H
INTERNAL_ROM_END = 01FFFH
EXTERNAL_ROM_START = 02000H
EXTERNAL_ROM_END = 0FEBFH
INTERNAL_RAM_START = 0FEC0H
INTERNAL_RAM_END = 0FFBFH

EXTERNAL_ROM_SIZE = 0FFFFH			;	64KB - To be stored in a 27C512 EPROM

LED_ADDRESS = 00000H

; Addresses for TLCS-90 special registers:
BX = 0FFECH
BY = 0FFEDH
P01CR_IRFL = 0FFC2H
P2CR = 0FFC5H
P3CR = 0FFC7H
P4CR = 0FFC9H
P67CR = 0FFCEH
P8CR = 0FFD1H
TRUN = 0FFDBH
TMOD = 0FFDAH
TCLK = 0FFD8H
TFFCR = 0FFD9H
TREG2 = 0FFD6H
TREG3 = 0FFD7H
INTEH = 0FFE7H
INTEL = 0FFE6H
T4MOD = 0FFE4H
TREG4L = 0FFE0H
TREG4H = 0FFE1H
TREG5L = 0FFE2H
TREG5H = 0FFE3H
SMMOD = 0FFCBH
ADMOD = 0FFEFH
WDMOD = 0FFD2H
WDCR = 0FFD3H
DMAEH = 0FFE8H


	ORG 0H
	di
	ld    d,00H
	ld    sp,INTERNAL_RAM_END
	inc   sp
	jp    init_device

	ORG 10H
	reti

	ORG 18H
	jp    nmi_handler

	ORG 20H
	reti

	ORG 28H
	reti

	ORG 30H
	reti

	ORG 38H
	reti

	ORG 40H
	reti

	ORG 48H
	reti

	ORG 50H
	reti

	ORG 58H
	reti

	ORG 60H
	reti

; Version: 'V-01'
	db    56H
	db    2DH
	db    30H
	db    31H

	ORG 68H
	reti

	ORG 70H
	reti

	ORG 78H
	reti
	
nmi_handler:
	reti


; MESSAGE: 'NMK215 Dump Program Code by Recreativos Piscis(C)2023 (a)Recre_Piscis '
	db    4EH
	db    4DH
	db    4BH
	db    32H
	db    31H
	db    35H
	db    20H
	db    44H
	db    75H
	db    6DH
	db    70H
	db    20H
	db    50H
	db    72H
	db    6FH
	db    67H
	db    72H
	db    61H
	db    6DH
	db    20H
	db    43H
	db    6FH
	db    64H
	db    65H
	db    20H
	db    62H
	db    79H
	db    20H
	db    52H
	db    65H
	db    63H
	db    72H
	db    65H
	db    61H
	db    74H
	db    69H
	db    76H
	db    6FH
	db    73H
	db    20H
	db    50H
	db    69H
	db    73H
	db    63H
	db    69H
	db    73H
	db    28H
	db    43H
	db    29H
	db    32H
	db    30H
	db    32H
	db    33H
	db    20H
	db    28H
	db    61H
	db    29H
	db    52H
	db    65H
	db    63H
	db    72H
	db    65H
	db    5FH
	db    50H
	db    69H
	db    73H
	db    63H
	db    69H
	db    73H
	db    20H


init_device:
	ld    (BX),08H					;	Load $08 into BX  (to address EEPROM space)				-	Set 08 as X Bank Register : A16-A19 pointing to the EEPROM area: $80000
	ld    (BY),0FH					;	Load $0F into BY  (to address LED space)				-	Set 0F as Y Bank Register : A16-A19 pointing to the LED area: $F0000
	ld    iy,LED_ADDRESS			;	To effectively address: $F0000
	ld    (P01CR_IRFL),07H			;	Load $07 into P01CR register	(0000 0111)				-	Interrupt controller: bits 6,5,4=0; Bit 2 (EXT): Set as address bus of Port 1
	ld    (P2CR),0FFH				;	Load $FF into P2CR register		(1111 1111)				-	Set as address bus of Port 2
	ld    (P3CR),20H				;	Load $20 into P3CR register		(0010 0000)				-	Set: WAIT: 2-state; /RD as fixed pin; P33 to Open-Drain; P30, P31 as input ports; P32, P33 as output ports
	ld    (P4CR),0FH				;	Load $0F into P4CR register		(0000 1111)				-	Set: Port 4 as address bus (4 MSB of address bus: A16-A19)  (0 value denotes output port; 1 value denotes addresss bus)
	ld    (P67CR),00H				;	Load $00 into P67CR register	(0000 0000)				-	Set: Port 6 and 7 as inputs (0 value denotes input pins; 1 value denotes output pins)
	ld    (P8CR),00H				;	Load $00 into P8CR register		(0000 0000)				-	Set: Port 8: P83 as port pin, P82 zero-cross disabled, P81 zero-cross disabled, INT0 level High detection
	ld    (TRUN),00H				;	Load $00 into TRUN register		(0000 0000)				-	Set: 300/150 baud, and all timers as "Stop and clear"
	ld    (TMOD),00H				;	Load $00 into TMOD register		(0000 0000)				-	
	ld    (TCLK),00H				;	Load $00 into TCLK register		(0000 0000)				-	
	ld    (TFFCR),00H				;	Load $00 into TFFCR register	(0000 0000)				-
	ld    (TREG2),00H				;	Load $00 into TREG2 register	(0000 0000)
	ld    (TREG3),00H				;	Load $00 into TREG3 register	(0000 0000)
	ld    (INTEH),00H				;	Load $00 into INTEH register	(0000 0000)				-	Set: Disable all interrupt levels and disable DMA interrupts
	ld    (INTEL),00H				;	Load $00 into INTEL register	(0000 0000)				-	Set: Disable all interrupt levels
	ld    (T4MOD),00H				;	Load $00 into T4MOD register	(0000 0000)
	ld    (TREG4L),00H				;	Load $00 into TREG4L register	(0000 0000)
	ld    (TREG4H),00H				;	Load $00 into TREG4H register	(0000 0000)
	ld    (TREG5L),00H				;	Load $00 into TREG5L register	(0000 0000)
	ld    (TREG5H),00H				;	Load $00 into TREG5H register	(0000 0000)
	ld    (SMMOD),00H				;	Load $00 into SMMOD register	(0000 0000)				-	Set: Port 6 and 7 as regular ports; Set motors values (don't care)
	ld    (ADMOD),00H				;	Load $00 into ADMOD register	(0000 0000)				-	Set: Analog port values (don't care)
	ld    (WDMOD),74H				;	Load $74 into WDMOD register	(0111 0100)				-	Set: Watchdog disable; Detecting perios and warm-up values (not used); STOP mode for HALT; Drive 0 on STOP mode
	ld    (WDCR),0B1H				;	Load $B1 into WDCR register		(1011 0001)				-	Set: $B1 code to disable watchdog
	ld    (DMAEH),00H				;	Load $00 into DMAEH register	(0000 0000)				-	Set: Disable all DMA interrupt levels

	jp    external_rom


	ORG EXTERNAL_ROM_START
external_rom:
	ld    (iy),01H					;	Turn ON the LED
	halt

copy_process:
	di
	ld    (iy),00H					;	Turn OFF the LED
	ld    bc,EXTERNAL_ROM_START		;	Set the size of the memory area to be copied
	ld    hl,INTERNAL_ROM_START		;	Init source..
	ld    ix,hl						;	... and destination address registers

copy_word_step:
	ld    de,(hl)					;	Copy 2-byte data from source address to DE register
	ld    (ix),de					;	Copy 2-byte data from DE register to destination address
	dec   bc						;	Decrement by 2 units the source zone address...
	dec   bc						;	... because the previous data copy was 16-bit wide (word)
	inc   hl						;	Increment source address by 2 units...
	inc   hl						;	
	ld    ix,hl						;	... and so do for the destination address
	cp    b,00H						;	Check if B register already turns out 0...
	jp    nz,copy_word_step			;	... if not, jump back to copy next word
	cp    c,00H						;	Check if C register already turns out 0...
	jp    nz,copy_word_step			;	... if not, jump back to copy next word

end_process:						;	
	jp    external_rom				;	Jump back to start of the process and stop indefinitely. If another interrupt is generated, the process is repeated again


	ORG EXTERNAL_ROM_SIZE
	db    0FFH						;	Pad up to 0xFFFF filling the output file with 0xFF values to complete the 64KB file (27C512 size)