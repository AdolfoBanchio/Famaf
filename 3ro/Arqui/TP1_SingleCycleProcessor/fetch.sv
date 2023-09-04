module fetch (input logic PCSrc_F,clk,reset,
			  input logic [64:0]PCBranch_F,
			  output logic [64:0]imem_addr_F);
logic [64:0]d,y;
mux2 mux_f(PCBranch_F,y,PCSrc_F,d);
flopr #(64) flopr_f (clk,reset,d,imem_addr_F);
adder #(64) adder_f (imem_addr_F,'d4,y);
endmodule