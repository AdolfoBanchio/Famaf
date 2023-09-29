module circuito
(input logic clk, r, enable, sel,
input logic [7:0] A, B,
output logic [7:0] Q,
output logic [3:0] L);
logic [7:0] Q_temp;
always_ff @ (posedge clk, negedge r)
begin
if (~r)
Q_temp <= 8'b0;
else if (enable)
if (sel)
Q_temp <= Q_temp ^ A;
else
Q_temp <= Q_temp & B;
end
assign L = A[7:4];
assign Q = Q_temp;
endmodule