module alu_tb();
	logic clk,reset, zero, expected_zero;
	logic [63:0]a,b,result, expected_result;
	logic [3:0] aluControl;
	logic [63:0] vectornum, errors;
	logic [131:0] testvector [0:14] ='{//alucontrol b a 
													{4'b0000,64'b10101,64'b01010},//and
													{4'b0000,{61{1'b1}},3'b001,{61{1'b1}},3'b011},
													{4'b0000,{61{1'b1}},3'b001,64'b111},
													
													{4'b0000,64'b10101,64'b01010},//or TODO
													{4'b0000,{61{1'b1}},3'b001,{61{1'b1}},3'b011},
													{4'b0000,{61{1'b1}},3'b001,64'b111},
													
													{4'b0010,64'd4,64'd9},//add
													{4'b0010,-64'd7,-64'd3},
													{4'b0010,-64'd7,64'd3},
													
													{4'b0110,64'd4,64'd9},//substract
													{4'b0110,-64'd7,-64'd3},
													{4'b0110,-64'd7,64'd3},
													
													{4'b0111,64'b10101,64'b01010},//pass b
													{4'b0111,{61{1'b1}},3'b001,{61{1'b1}},3'b011},
													{4'b0111,{61{1'b1}},3'b001,64'b111}
													};
													//terminar los otros casos
	logic [64:0] testvector_result [0:14] ='{ 
															{1'b1,64'b00000},//and
															{1'b0,{61{1'b1}},3'b001},
															{1'b0,{61{1'b0}},3'b001},
											
															{1'b1,64'b00000},//or TODO
															{1'b0,{61{1'b1}},3'b001},
															{1'b0,{61{1'b0}},3'b001},
															
															{1'b0,64'd13},//add
															{1'b0,-64'd10},
															{1'b0,-64'd4},
															
															{1'b0,64'd5},//substract
															{1'b0,64'd4},
															{1'b0,64'd10},
															
															{1'b1,64'b10101},//pass b
															{1'b0,{61{1'b1}},3'b001},
															{1'b0,{61{1'b1}},3'b001}
														};
	
	alu dut(a,b,aluControl,result,zero);
	always begin 
			clk = 1; #5ns; clk=0; #5ns;
	end
			
	initial 
		begin 
			vectornum= 0; errors = 0; reset = 1;#30;
			reset = 0;
		end
	
	always @(posedge clk) begin 
			#1; 
			{aluControl,b,a} = testvector[vectornum];
			{expected_zero,expected_result} = testvector_result[vectornum];
	end

	always @(negedge clk)
			if(~reset) begin //durante el reset skip, para que el sistema se acostumbre a las condiciones
				if(result !== expected_result) begin
					$display("Error: input a = %b input b = %b aluOperation = %b", a,b,aluControl);
					$display("output = %b (%b expected) zero = %b (%b expected)",result,expected_result,zero,expected_zero);
					errors = errors + 1;
				end
			vectornum = vectornum +1;
			if (testvector[vectornum] === 'bx) begin 
				$display("%d tests completed with %d errors",vectornum, errors);
				// $finish;
				$stop;
			end
		end
endmodule