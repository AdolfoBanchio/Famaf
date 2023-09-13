// DATAPATH

module datapath #(parameter N = 64)
				 (input logic reset, clk,
				  input logic reg2loc,
				  input logic [1:0] AluSrc,
				  input logic [3:0] AluControl,
				  input logic Branch,
				  input logic memRead,
				  input logic memWrite,
				  input logic regWrite,
				  input logic memtoReg,				  
				  input logic [31:0] IM_readData,
				  input logic [N-1:0] DM_readData,
				  input logic [3:0] EStatus,
				  input logic Exc, ERet,
				  output logic [N-1:0] IM_addr, DM_addr, DM_writeData,
				  output logic DM_writeEnable, DM_readEnable,
				  output logic ExcAck);

	logic PCSrc;
	logic [N-1:0] E_Branch, PCBranch, writeData3;
	logic [N-1:0] signImm, readData1, readData2, readData3;
	logic [N-1:0] NextPC, EVAddr;
	logic EProc;
	logic zero;


	fetch #(64) 	FETCH      (.PCSrc_F(PCSrc),
								.clk(clk),
								.reset(reset),
								.EProc_F(EProc),
								.PCBranch_F(PCBranch),
								.EVAddr_F(EVAddr),
								.imem_addr_F(IM_addr),
								.NextPC_F(NextPC));



	decode #(64)	DECODE     (.regWrite_D(regWrite),
								.reg2loc_D(reg2loc),
								.clk(clk),
								.writeData3_D(writeData3),
								.instr_D(IM_readData),
								.signImm_D(signImm),
								.readData1_D(readData1),
								.readData2_D(readData2));



	execute #(64)   EXECUTE    (.AluSrc(AluSrc),
								.AluControl(AluControl),
								.PC_E(IM_addr),
								.signImm_E(signImm),
								.readData1_E(readData1),
								.readData2_E(readData2),
								.readData3_E(readData3),
								.PCBranch_E(E_Branch),
								.aluResult_E(DM_addr),
								.writeData_E(DM_writeData),
								.zero_E(zero));

	memory  		MEMORY     (.Branch_M(Branch),
								.zero_M(zero),
								.PCSrc_M(PCSrc));



	writeback #(64) WRITEBACK  (.aluResult_W(DM_addr),
								.DM_readData_W(DM_readData),
								.memtoReg(memtoReg),
								.writeData3_W(writeData3));
	

	exception       EXCEPTION  (.clk(clk), .reset(reset),
								.Exc(Exc), .ERet(ERet),
								.EStatus(EStatus),
								.NextPC_X(NextPC),
								.imem_addr_X(IM_addr),
								.ALUBranch_X(E_Branch),
								.EDataSel(IM_readData[13:12]),
								.ExcAck(ExcAck),
								.EProc_X(EProc),
								.PCBranch_X(PCBranch),
								.readData_X(readData3),
								.EVAddr_X(EVAddr));
	// Salida de señales de control:
	assign DM_writeEnable = memWrite;
	assign DM_readEnable = memRead;

endmodule
