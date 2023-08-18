module mux2(input logic [3:0] d20, d21,
				input logic s2,
				output logic [3:0] y2);
assign y2 = s2 ? d21 : d20;
endmodule