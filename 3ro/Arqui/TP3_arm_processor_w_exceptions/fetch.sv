module fetch #(parameter N=64)
			  (input logic PCSrc_F, clk, reset, EProc_F,
			   input logic [N-1:0] PCBranch_F, EVAddr_F,
			   output logic[N-1:0] imem_addr_F, NextPC_F);

	logic [N-1:0] PC_out, adder_out, mux1_out, mux2_out;

	flopr #(N) PC   (clk, reset, mux2_out, PC_out);
	adder #(N) Add  (PC_out, 64'h4, adder_out);
	mux2  #(N) MUX1 (adder_out, PCBranch_F, PCSrc_F, mux1_out);
	mux2  #(N) MUX2 (mux1_out, EVAddr_F, EProc_F, mux2_out);

	assign imem_addr_F = PC_out;
	assign NextPC_F = mux1_out;
endmodule
