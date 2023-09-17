// INSTRUCTION MEMORY

module imem #(parameter N=32)
			 (input logic [6:0] addr,
			  output logic [N-1:0] q);

	logic [N-1:0] ROM [0:127];
	
	initial
	begin	
		ROM  = '{default:'0};	
		// Código ensamblado:
      ROM [0:6] ='{32'h8b030041,
32'hf8000001,
32'hcb0101e2,
32'hf8004002,
32'hf8400003,
32'h8b020064,
32'hf8408004};

	end
	
	assign q = ROM[addr];
endmodule
