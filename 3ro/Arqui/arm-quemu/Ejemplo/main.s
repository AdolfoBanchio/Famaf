	.data
	N:       .dword 3	
	t_amb:   .dword 5   
	n_iter:  .dword 10    
	# declare heat source coordinates
	fc_x: 	 .dword 0
	fc_y: 	 .dword 0
	# declare heat source variable as float value of 100.25
	fc_temp: .dword 25

	.bss 
	x: .zero  72      
	x_temp: .zero  72    

	.arch armv8-a
	.text
	MRS X9, CPACR_EL1 // Read EL1 Architectural Feature Access Control Register
	MOVZ X10, 0x0030, lsl #16 // Set BITs 20 and 21
	ORR X9, X9, X10
	MSR CPACR_EL1, X9 // Write EL1 Architectural Feature Access Control Register

	ldr     x0, N
	ldr 	d0, N
    ldr     x1, =x 
    ldr     x2, =x_temp
    ldr     x3, n_iter
	ldr     x4, t_amb
	ldr     d4, t_amb
	ldr     d5, fc_temp

	ldr 		x20, fc_x
	ldr 		x21, fc_y
	

	# intialize the matrix with t_amb
	mov 	x6, x1
	mov 	x7, 0
load:	
	str     x4, [x6]
	add 	x6, x6, 8
	add 	x7, x7, 1
	cmp 	x7, #9
	b.ne 	load

	# set the heat source temperature
	str     d5,[x1]
	//---------------------- CODE HERE ------------------------------------

  	mov 	x5, 0 // k
	mul 	x9, x0, x0 // N*N

FOR_K:
	cmp x5, x3
	b.eq END_K
	add x5, x5, 1
	mov	x6, 0 // i
	mov	x7, 0 // j
	mov x8, 0 // i2

FOR_J:
	cmp x7, x0
	b.eq INCR_I
	// code

	// if((i*N+j) != (fc_x*N+fc_y)){
	mul x10, x6, x0
	add x10, x10, x7
	# madd x10, x6, x0, x7
	mul x11, x20, x0
	add x11, x11, x21
	# madd x11, x20, x0, x21
	cmp x10, x11
	b.eq INCR_J

	fmov d10, xzr
	add x10, x6, 1 // i + 1
	sub x11, x6, 1 // i - 1
	add x12, x7, 1 // j + 1
	sub x13, x7, 1 // j - 1

	// if(i + 1 < N)
  cmp x10, x0
	b.ge ELSE_1
	mul x14, x10, x0
	add x14, x14, x7
	# madd x14, x10, x0, x7
	lsl x14, x14, 3
	ldr d11, [x1,x14] // x[(i+1)*N + j]
	add d10, d10, d11 // sum = sum + x[(i+1)*N + j];
	b IF_2
ELSE_1: 
	bl ELSE  
	
IF_2: // if(i - 1 >= 0)
	cmp x11, xzr
	b.lt ELSE_2
	mul x14, x11, x0
	add x14, x14, x7
	lsl x14, x14, 3
	# madd x14, x11, x0, x7
	ldr d11, [x1, x14] // x[(i-1)*N + j
	add d10, d10, d11 // sum = sum + x[(i-1)*N + j];
	b IF_3
ELSE_2:
	bl ELSE

IF_3:	// if(j + 1 < N)
	cmp x12, x0
	b.ge ELSE_3
	mul x14, x6, x0
	add x14, x14, x12
	lsl x14, x14, 3
  	# madd x14, x6, x0, x12
	ldr d11, [x1, x14] // x[i*N + (j + 1)
	add d10, d10, d11 // sum = sum + x[i*N + (j + 1)];
	b IF_4
ELSE_3:
	bl ELSE
	
IF_4: // if(j - 1 >= 0)
	cmp x13, xzr
	b.lt ELSE_4
	mul x14, x6, x0
	add x14, x14, x13
	lsl x14, x14, 3
	# madd x14, x6, x0, x13 
	ldr d11, [x1, x14]
	add d10, d10, d11 // sum = sum + x[i*N + (j - 1)];
	b SAVE_V

ELSE_4:
	bl ELSE

SAVE_V:
	mul x14, x6, x0
	add x14, x14, x7
	lsl x14, x14, 3
	# madd x14, x6, x0, x7
	fmov d15, 4.0
	fdiv d10, d10, d15
	str d10, [x2, x14] // x_tmp[i*N + j] = sum / 4;
	b INCR_J
ELSE:
	add d10, d10, d4 // sum = sum + t_amb;
	ret
  // ----
INCR_J:	
	add x7, x7, 1
  b FOR_J

INCR_I:
	add x6, x6, 1
	cmp x6, x0
	b.eq FOR_I2
	mov		x7, 0 // j
	b FOR_J

FOR_I2:
	cmp x8, x9
	b.eq FOR_K
	// code
	mul x14 , x20 , x0
	add x14, x14, x21
	# madd x14, x20, x0, x21
	cmp x8, x14
	b.eq INCR_I2
	lsl x14, x8, 3
	ldr d15, [x2, x14]
	str d15, [x1, x14] // x[i] = x_tmp[i];
	// ---
INCR_I2:
	add x8,x8,1
	b FOR_I2
	
END_K:

end:
infloop: B infloop
