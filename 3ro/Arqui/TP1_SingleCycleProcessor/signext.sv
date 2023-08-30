module signext(input logic [31:0] a,
					output logic [63:0] y);
					
always_comb
	begin
		if (a[31:21] == 11'b111_1100_0010 || a[31:21] == 11'b111_1100_0000) begin
				y = {{55{a[20]}},a[20:12]};
		end else if (a[31:21] == 11'b101_1010_0???) begin
				y ={{44{a[23]}},a[23:5]};
		end else y = 0;
	end
endmodule 