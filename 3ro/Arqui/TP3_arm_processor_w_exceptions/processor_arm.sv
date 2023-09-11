// TOP-LEVEL PROCESSOR

module processor_arm #(parameter N = 64)
					  (input logic CLOCK_50, reset,
					   input logic ExtIRQ,
					   output logic [N-1:0] DM_writeData, DM_addr,
					   output logic DM_writeEnable,
					   output logic ExtIAck,
					   input	logic dump);

	logic [31:0] q;
	logic [3:0] AluControl;
	logic reg2loc, regWrite, memtoReg, memRead, memWrite;
	logic [1:0] AluSrc;
	logic Exc, ExcAck, ERet, Branch;
	logic [3:0] EStatus;
	logic [N-1:0] DM_readData, IM_address; //DM_addr, DM_writeData
	logic DM_readEnable; //DM_writeEnable

	controller  	c  (.reset(reset),
						.instr(q[31:21]),
						.ExcAck(ExcAck),
						.ExtIRQ(ExtIRQ),
						.AluControl(AluControl),
						.reg2loc(reg2loc),
						.regWrite(regWrite),
						.AluSrc(AluSrc),
						.Branch(Branch),
						.memtoReg(memtoReg),
						.memRead(memRead),
						.memWrite(memWrite),						
						.Exc(Exc),
						.ERet(ERet),
						.EStatus(EStatus),
						.ExtIAck(ExtIAck));


	datapath #(64)  dp (.reset(reset),
						.clk(CLOCK_50),
						.reg2loc(reg2loc),
						.AluSrc(AluSrc),
						.AluControl(AluControl),
						.Branch(Branch),
						.memRead(memRead),
						.memWrite(memWrite),
						.regWrite(regWrite),						
						.memtoReg(memtoReg),
						.IM_readData(q),
						.DM_readData(DM_readData),
						.IM_addr(IM_address),
						.DM_addr(DM_addr),
						.DM_writeData(DM_writeData),
						.DM_writeEnable(DM_writeEnable),
						.DM_readEnable(DM_readEnable),
						.Exc(Exc),
						.ERet(ERet),
						.EStatus(EStatus),
						.ExcAck(ExcAck));


	imem	instrMem   (.addr(IM_address[8:2]),
						.q(q));


	dmem	dataMem    (.clk(CLOCK_50),
						.memWrite(DM_writeEnable),
						.memRead(DM_readEnable),
						.address(DM_addr[10:3]),
						.writeData(DM_writeData),
						.readData(DM_readData),
						.dump(dump));

endmodule
