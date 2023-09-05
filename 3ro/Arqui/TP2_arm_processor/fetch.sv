module fetch #(parameter N = 64) (
		input logic PCSrc_F, clk, reset,
		input logic [N-1:0] PCBranch_F,
		output logic [N-1:0] imem_addr_F
	);

	logic [N-1:0] add_out;
	logic [N-1:0] mux2_out;

	mux2 #(N) mux(add_out, PCBranch_F, PCSrc_F, mux2_out);
	flopr #(N) pc(clk, reset, mux2_out, imem_addr_F);
	adder #(N) add(imem_addr_F, N'('d4), add_out);

endmodule