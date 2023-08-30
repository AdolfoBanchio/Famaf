module flopr_tb();
	logic clk, reset;
	logic [63:0] in, out, expectedout;
	
	logic [63:0] vectornum, errors;
	logic [127:0] testvectors [0:9] ='{128'h0000000000000000_0000000000000000,
												 128'h0000000000000001_0000000000000000,
												 128'h0000000000000002_0000000000000000,
												 128'h0000000000000003_0000000000000000,
												 128'h0000000000000005_0000000000000000,
												 128'h0000000000000006_0000000000000006,
												 128'h00000007_0000000000000007,
												 128'h00000008_0000000000000008,
												 128'h00000009_0000000000000009,
												 128'h0000000A_000000000000000A};
	flopr #(64) dut(clk,reset,in,out);
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
				expectedout = testvectors[vectornum][63:0];
			end

		always @(negedge clk)
			in = testvectors[vectornum][127:64]; #10;
			if (~reset) begin 
				if(out !== expectedout) begin
					$display("Error: input = %h", in);
					$display("output = %h (%h expected) reset = %h",out,expectedout,reset);
					errors = errors + 1;
				end
				vectornum = vectornum +1;
				if (testvectors[vectornum] === 128'bx) begin 
					$display("%d tests completed with %d errors",vectornum, errors);
					// $finish;
					$stop;
				end
			end
endmodule