module flopr_tb();
	logic clk, reset;
	logic [63:0] in, out, expectedout;
	
	logic [63:0] vectornum, errors;
	logic [127:0] testvectors [0:9] ='{
												 128'h0_0000000000000000,
												 128'h1_0000000000000000,
												 128'h2_0000000000000000,
												 128'h3_0000000000000000,
												 128'h5_0000000000000000,
												 128'h6_0000000000000005,
												 128'h7_0000000000000006,
												 128'h8_0000000000000007,
												 128'h9_0000000000000008,
												 128'hA_0000000000000009};
	flopr #(64) dut(clk,reset,in,out);
	always begin 
			clk = 1; #5ns; clk=0; #5ns;
	end
			
	initial 
		begin 
			vectornum= 0; errors = 0; reset = 1;#50ns;
			reset = 0;
		end
	
	always @(posedge clk) begin 
			#1; expectedout = testvectors[vectornum][63:0];
	end

	always @(negedge clk) begin
		#1; in = testvectors[vectornum][127:64]; 
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