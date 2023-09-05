module imem #(parameter N = 32)(
    input logic [5:0] addr,
    output logic [N-1:0] q
);

    logic [N-1:0] ROM [0:63];

    initial begin
        ROM [0:7] ='{32'h8b1f03e2,
							32'hcb1e0003,
							32'hb40000a3,
							32'hf8000040,
							32'h8b000020,
							32'h8b080042,
							32'hb4ffff7f,
							32'hb400001f};
        for (int i = 8; i <= N-1; i++) begin
            ROM[i] = 0;
        end
    end

    assign q = ROM[addr];

endmodule
