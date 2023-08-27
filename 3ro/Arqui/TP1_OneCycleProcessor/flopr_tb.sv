module flopr_tb();
	logic clk, reset;
	logic in, out;
	flopr dut(clk,reset,in,out);

	always 
		begin 
			clk = 1; #5; clk=0; #5;
		end
endmodule