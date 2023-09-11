module exception (input logic clk, reset, Exc, ERet,
				  input logic [3:0] EStatus,
				  input logic [63:0] NextPC_X, imem_addr_X, ALUBranch_X,
				  input logic [1:0] EDataSel,
				  output logic ExcAck, EProc_X,
				  output logic [63:0] PCBranch_X, readData_X,
				  output logic [63:0] EVAddr_X);

	logic [63:0] Exc_vector = 64'hD8;
	assign EVAddr_X = Exc_vector;

	logic comp_out, sync_out, EProc;
	assign EProc = sync_out & ~reset;
	assign EProc_X = EProc;
	assign ExcAck = comp_out;

	comp_n  #(64) EV_Comp (imem_addr_X, Exc_vector, comp_out);
	esync         ESync   (Exc, comp_out, reset, sync_out);

	logic [63:0] ERR_out, ELR_out;
	logic [3:0] ESR_out;
	flopr_e #(64) ERR     (clk, reset, EProc, NextPC_X, ERR_out);
	flopr_e #(64) ELR     (clk, reset, EProc, imem_addr_X, ELR_out);
	flopr_e #(4)  ESR     (clk, reset, EProc, EStatus , ESR_out);

	mux2    #(64) RET_SEL (ALUBranch_X, ERR_out, ERet, PCBranch_X);
	mux4    #(64) D_SEL   (ERR_out, ELR_out, {60'b0, ESR_out}, 64'b0, EDataSel, readData_X);
endmodule
