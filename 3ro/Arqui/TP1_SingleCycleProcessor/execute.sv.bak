module execute #(parameter N = 64) (
		input logic AluSrc,
		input logic [3:0] AluControl,
		input logic [N-1:0] PC_E, signImm_E, readData1_E, readData2_E,
		output logic [N-1:0] PCBranch_E, aluResult_E, writeData_E,
		output logic zero_E
	);

	logic [N-1:0] MUX_out;
	logic [N-1:0] sl2_out;

	mux2 #(N) MUX(readData2_E, signImm_E, AluSrc, MUX_out);
	sl2 #(N) sl2(signImm_E, sl2_out);
	adder #(N) adder(PC_E, sl2_out, PCBranch_E);
	alu #(N) alu(readData1_E, MUX_out, AluControl, aluResult_E, zero_E);

	assign writeData_E = readData2_E;

endmodule