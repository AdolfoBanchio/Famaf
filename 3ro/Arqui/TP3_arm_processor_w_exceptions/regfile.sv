module regfile #(parameter N=64)
				(input logic clk,	we3,
			 	 input logic [4:0] ra1, ra2, wa3,
			 	 input logic [N-1:0] wd3,
			 	 output logic [N-1:0] rd1, rd2);

	logic [N-1:0] REGS [0:31];
	
	initial 
	begin
		REGS  = '{default:'0};
		for (logic [N-1:0] i = 0; i < 'd31; ++i) REGS[i] = i;
	end
	
	always @(posedge clk)
		if (we3)
			REGS[wa3] <= wd3;

		always_comb begin
			rd1 <= (ra1 == 5'd31) ? 64'b0 : REGS[ra1];
			rd2 <= (ra2 == 5'd31) ? 64'b0 : REGS[ra2];
		end

endmodule
