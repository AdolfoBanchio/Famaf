	.data
	N:       .dword 9	// Number of elements in the vectors
	
	.bss 
	Array: .zero  72        // vector X(1000)*8

	.arch armv8-a
	.text
	MRS X9, CPACR_EL1 // Read EL1 Architectural Feature Access Control Register
	MOVZ X10, 0x0030, lsl #16 // Set BITs 20 and 21
	ORR X9, X9, X10
	MSR CPACR_EL1, X9 // Write EL1 Architectural Feature Access Control Register

	// Initilize randomply the array
	ldr x0, =Array	       // Load array base address to x0
	ldr x6, N             // Load the number of elements into x2
    mov x1, 1234         // Set the seed value
	mov x5, 0		    // Set array counter to 0

    // LCG parameters (adjust as needed)
    movz x2, 0x5, lsl 0    //5         // Multiplier
	//movk x2, 0x660D, lsl 0
    movz x3, 0x1, lsl 0  // 1013904223      // Increment
	//movk x3, 0xF35F, lsl 0
    //movz x4, 0xFFFF, lsl 16  // Modulus (maximum value)
    movk x4, 0xFFFF, lsl 0   // Modulus (maximum value)

random_array:
    	// Calculate the next pseudorandom value
    mul x1, x1, x2          // x1 = x1 * multiplier
    add x1, x1, x3          // x1 = x1 + increment
    and x1, x1, x4          // x1 = x1 % modulus
	str x1, [x0]	    // Store the updated seed back to memory
	add x0, x0, 8	    // Increment array base address 
	add x5, x5, 1	    // Increment array counter 
	cmp	x5, x6		    // Verify if process ended
	b.lt	random_array

    ldr x2, N
	sub x3, x2, 1 // N-1 <- Is used in the loop
    ldr x1, =Array

//---------------------- CODE HERE ------------------------------------
bubble_sort:
    mov     x8, 0             // Outer loop counter for(i=0; i<N-1, i++)
outer_loop:
	sub 	x4, x3, x8   	  // N-1-i
	add 	x14, x1, 0		 // x14 = x1 = =Array
    mov     x9, 0             // Inner loop counter for(j=0; j<N-1-i, j++)
inner_loop:
	ldp 	x10, x11, [x14]  // Load current element x[j] and next element x[j+1] 
    cmp     x10, x11           // Compare current and next elements
	
    b.gt    swap               // Branch if the current element is greater than the next

    b       no_swap            // Branch to no_swap if no swap is needed

swap:
	stp 	x11, x10, [x14]  // Swap current and next elements

no_swap:
    add     x9, x9, 1          // Move to the next pair of elements
	add     x14, x14, 8        // Move to the next pair of elements
    cmp     x9, x4             // Compare inner loop counter with N-1-i
    b.lt    inner_loop         // Branch to inner_loop if not finished

    add     x8, x8, 1          // Move to the next pair of elements in the outer loop
    cmp     x8, x3             // Compare outer loop counter with N
    b.lt    outer_loop         // Branch to outer_loop if not finished

end:
infloop: B infloop
