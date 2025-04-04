module mux4(input logic [3:0] d0, d1, d2, d3,
				input logic [1:0] s,
				output logic [3:0] y);
logic [3:0] low, high; // internal variables
mux2 lowmux(d0, d1, s[0], low); // instance of mux2
mux2 highmux(d2, d3, s[0], high); // instance of mux2
mux2 finalmux(low, high, s[1], y);// instance of mux2
endmodule