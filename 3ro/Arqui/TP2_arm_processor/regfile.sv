module regfile (input logic clk,we3,
				input logic [4:0]ra1,ra2,wa3,
				input logic [63:0]wd3,
				output logic [63:0]rd1,rd2
				);
logic [63:0] registers [0:31] = '{64'd0,64'd1,64'd2,64'd3,
								  64'd4,64'd5,64'd6,64'd7,
								  64'd8,64'd9,64'd10,64'd11,
								  64'd12,64'd13,64'd14,64'd15,
								  64'd16,64'd17,64'd18,64'd19,
								  64'd20,64'd21,64'd22,64'd23,
								  64'd24,64'd25,64'd26,64'd27,
								  64'd28,64'd29,64'd30,64'd0};
always_ff @(posedge clk) begin
	if(we3 === 1 && wa3 !== 31) begin	
		registers[wa3] = wd3;
	end
end
always_comb begin
	rd1 <= registers[ra1];
	rd2 <= registers[ra2];
end
endmodule