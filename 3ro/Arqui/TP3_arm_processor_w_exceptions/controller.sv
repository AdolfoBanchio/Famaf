// CONTROLLER

module controller(input logic [10:0] instr,
				input logic reset, ExtIRQ, ExcAck,
				output logic [3:0] AluControl, EStatus,
				output logic [1:0] AluSrc,
				output logic reg2loc, regWrite, Branch,
				memtoReg, memRead, memWrite, ERet, Exc, ExtIAck);
											
	logic [1:0] AluOp_s;
	logic NotAnInstr;										
	maindec 	decPpal 	(instr,
							reset,
							reg2loc,  
							memtoReg, 
							regWrite, 
							memRead,
							memWrite, 
							Branch,
							NotAnInstr,
							ERet,
							AluOp_s,
							AluSrc);	
					
								
	aludec 	decAlu 	(.funct(instr), 
							.aluop(AluOp_s), 
							.alucontrol(AluControl));

	always_comb begin
    Exc <= ExtIRQ || NotAnInstr;
    ExtIAck<= ExcAck && ExtIRQ;
    
    if (NotAnInstr)
        EStatus <= 4'b0010;
    else if (ExtIRQ)
        EStatus <= 4'b0001;
    else
        EStatus <= 4'b0000;
    end
endmodule
