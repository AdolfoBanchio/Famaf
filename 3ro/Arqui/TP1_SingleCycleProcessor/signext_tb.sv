module signext_tb();
	logic clk,reset;
	logic [63:0]y, expected_y;
	logic [31:0] a;
	logic [63:0] vectornum, errors;
	logic [31:0] testvector_a [0:6] ='{ 32'b111_1100_0010_001001100_00_00000_00000,
													32'b111_1100_0010_100000111_00_00000_00000,
													32'b111_1100_0000_001001100_00_00000_00000,
													32'b111_1100_0000_111100000_00_00000_00000,
													32'b101_1010_0_0000000000011001100_00000,
													32'b101_1010_0_1110000000011000000_00000,
													32'b111_1111_1_1110000000011000000_00000
													};
	logic [63:0] testvector_y [0:6] ='{ 64'b001001100,
													{{55{1'b1}},9'b100000111},
													64'b001001100,
													{{55{1'b1}},9'b111100000},
													64'b0000000000011001100,
													{{45{1'b1}},19'b1110000000011000000},
													64'b0
													};
	
	signext dut(a,y);
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
			expected_y = testvector_y[vectornum];
			a = testvector_a[vectornum];
	end

	always @(negedge clk)
			if(~reset) begin //durante el reset skip, para que el sistema se acostumbre a las condiciones
				if(y !== expected_y) begin
					$display("Error: input = %b", a);
					$display("output = %b (%b expected) ",y,expected_y);
					errors = errors + 1;
				end
			vectornum = vectornum +1;
			if (testvector_a[vectornum] === 'bx) begin 
				$display("%d tests completed with %d errors",vectornum, errors);
				// $finish;
				$stop;
			end
		end
endmodule