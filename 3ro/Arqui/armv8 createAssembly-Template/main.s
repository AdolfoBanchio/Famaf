	.text
	.org 0x0000
	add x1, x2, x3 //x1 =5
	stur x1, [x0, #0] //mem[0] = 5
	sub x2, x15, x1 //x2 = 15-5 = 10
	stur x2, [x0, #4] //mem[1] = 10
	ldur x3, [x0, #0] //x3 = mem[0] = 5
	add x4, x3, x2 //x4 = 5+10 = 15
	ldur x4, [x0, #8] //mem[2] = 10

