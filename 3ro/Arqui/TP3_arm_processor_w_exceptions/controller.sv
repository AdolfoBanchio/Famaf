// CONTROLLER

module controller(input logic [10:0] instr,
				input logic reset, ExtlRQ, ExcAck,
				output logic [3:0] AluControl, EStatus,
				output logic [1:0] AluSrc,
				output logic reg2loc, regWrite, Branch,
				memtoReg, memRead, memWrite, ERet, Exc, ExtlAck);
											
	logic [1:0] AluOp_s;
											
	maindec 	decPpal 	(instr, 
							reg2loc, 
							AluSrc, 
							memtoReg, 
							regWrite, 
							memRead,
							memWrite, 
							Branch, 
							AluOp_s);	
					
								
	aludec 	decAlu 	(.funct(instr), 
							.aluop(AluOp_s), 
							.alucontrol(AluControl));
			
endmodule
