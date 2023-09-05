// CONTROLLER

module controller(input logic [10:0] instr,
						output logic [3:0] AluControl,						
						output logic reg2loc, regWrite, AluSrc, Branch,
											memtoReg, memRead, memWrite);
											
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
