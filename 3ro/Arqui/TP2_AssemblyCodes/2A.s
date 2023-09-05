	.text
	.org 0x0000
	// N = 29
	ADD x2, xzr, xzr // x2 = 0
loop: // while x0 != 30
	SUB x3, x0, x30
	CBZ x3, end
	STUR x0, [x2, #0]
	ADD x0, x1, x0
	ADD x2, x2, x8
	CBZ xzr, loop
end:
infLoop:  
	cbz XZR, infLoop
