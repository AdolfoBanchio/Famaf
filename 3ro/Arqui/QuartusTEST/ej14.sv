module ej14 (input logic clk,x0,x1,x2,x3,
				output logic z0,z1,z2,z3);
logic y0,y1,y2,y3;
always_ff @ (posedge clk)
 begin
 z0 = y0; y0 = x0;
 y1= x1; z1 = y1;
 z2<= y2; y2 <= x2;
 //y3<= x3; z3 <= y3;
 end
endmodule