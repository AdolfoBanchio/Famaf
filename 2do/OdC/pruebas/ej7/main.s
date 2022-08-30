	.data
	A: .dword  0xFFFF0000
	.text
	ldr x0,A
	lsr x0,x0,16
infloop:
	b infloop

