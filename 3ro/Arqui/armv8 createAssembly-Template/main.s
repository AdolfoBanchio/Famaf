	.text
	.org 0x0000
	MOVZ x0, #0x0, LSL #0
	MOVZ x1, #0x8, LSL #0
	MOVZ x2, #0x10, LSL #0
	MOVZ x3, #0x18, LSL #0
	MOVZ x4, #0x1905, LSL #0
	MOVZ x5, #0x1905, LSL #16
	MOVZ x6, #0x1905, LSL #32
	MOVZ x7, #0x1905, LSL #48
	STUR x4, [x0, #0x0]
	STUR x5, [x1, #0x0]
	STUR x6, [x2, #0x0]
	STUR x7, [x3, #0x0]
