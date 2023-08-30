module flopr_tb();
	logic clk, reset;
	logic [63:0] in, out, expectedout;
	flopr #(64) dut(clk,reset,in,out);
	logic [63:0] vectornum, errors;
	logic [127:0] testvectors [0:9] ={128'h00000000_00000000,
												 128'h00000001_00000000,
												 128'h00000002_00000000,
												 128'h00000003_00000000,
												 128'h00000005_00000000,
												 128'h00000006_00000006,
												 128'h00000007_00000007,
												 128'h00000008_00000008,
												 128'h00000009_00000009,
												 128'h0000000A_0000000A};
	always 
		begin 
			clk = 1; #5; clk=0; #5;
		end
	initial 
		begin 
			vectornum= 0; errors = 0; reset = 1;#50;
			reset = 0;
		end
	
		always @(posedge clk)
			begin 
				{expectedout, in} = testvectors[vectornum]; #10;
			end

		always @(negedge clk)
			if (~reset) begin 
				if(out !== expectedout) begin
					$display("Error: input = %h", in);
					$display("output = %h (%h expected) reset = %h",out,expectedout,reset);
					errors = errors + 1;
				end
				vectornum = vectornum +1;
				if (testvectors[vectornum] === 128'bx) begin 
					$display("%h tests completed with %h errors",vectornum, errors);
					// $finish;
					$stop;
				end
			end
endmodule