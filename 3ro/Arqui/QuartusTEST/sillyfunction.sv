module sillyfunction
(input logic clk,a, b, c, d,
output logic x, y);
logic n1, n2;
logic areg, breg, creg, dreg;
always_ff @(posedge clk) begin
areg <= a;
breg <= b;
creg <= c;
dreg <= d;
x <= n2;
y <= ~(dreg | n2);
end
assign n1 = areg & breg;
assign n2 = n1 | creg;
endmodule
