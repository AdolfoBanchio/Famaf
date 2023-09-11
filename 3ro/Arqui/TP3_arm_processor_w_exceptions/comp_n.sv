module comp_n #(parameter N=64)
			   (input logic [N-1:0] a, b,
				output logic eq);
	assign eq = a === b;
endmodule
