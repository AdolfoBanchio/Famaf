	.text
	.org 0x0000
	STUR X1, [X0, #0]
	STUR X2, [X0, #8]
	STUR X3, [X16, #0]
	ADD X3, X4, X5
	STUR X3, [X0, #24]
finloop:	CBZ XZR, finloop
