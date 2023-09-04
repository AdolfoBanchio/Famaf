module regfile_tb();
	logic clk,we3,reset;
	logic [4:0]ra1,ra2,wa3;
	logic [63:0]wd3;
	logic [63:0]rd1,rd2,expected_rd1,expected_rd2;
	logic [4:0] testv_ra [0:33];
	logic [63:0] testv_rd [0:33];
	logic [5:0] testv_wea [0:33];//valores para we y wa
	logic [63:0] testv_wd [0:33];
	logic [63:0] index,errors;
	regfile dut(clk,we3,ra1,ra2,wa3,wd3,rd1,rd2);
	
	always begin 
			clk = 1; #5ns; clk=0; #5ns;
	end
			
	initial begin 
			errors = 0; index = 0;reset = 1;
			for(int i=0; i<=30; i++) begin 
				testv_ra[i]=i;
				testv_rd[i]=i;
				testv_wea[i] = {1'b0,i};
				testv_wd[i] = 'd100;
			end
			//ciclo 31 leo xzr e intento escribirlo
			testv_ra[31]=31;
			testv_rd[31]=0;
			testv_wea[31]=6'b1_11111;
			testv_wd[31] = 'd100;
			//ciclo 32 chequeo que el xzr siga 0 y escribo otro registro
			testv_ra[32]=31;
			testv_rd[32]=0;
			testv_wea[32]=6'b1_00000;
			testv_wd[32] = 'd100;
			//ciclo 33 deshabilito escritura y chequeo que escribi bien el registro 0
			testv_ra[33]=0;
			testv_rd[33]='d100;
			testv_wea[33]=6'b0_00000;
			testv_wd[33] = 'd101;
			
			we3 = 0;
			wa3 = 0;
			wd3 = 0;
			#10ns;reset = 0;
		end
	
	always @(posedge clk) begin 
			#3;
			{we3,wa3} = testv_wea[index];
			wd3 = testv_wd[index];
			#3
			ra1 = testv_ra[index];
			ra2 = testv_ra[index];
			expected_rd1 = testv_rd[index];
			expected_rd2 = testv_rd[index];
			
	end

	always @(negedge clk)
			if(~reset) begin //durante el reset skip, para que el sistema se acostumbre a las condiciones
				if(rd1 !== expected_rd1 && rd2 !== expected_rd2) begin
					$display("Error: ra1 = %d ra2 = %d",ra1,ra2);
					$display("output  rd1 = %d (%d expected) rd2 = %d (%d expected))",rd1,expected_rd1,rd2,expected_rd2);
					errors = errors + 1;
				end
			index = index+1;
			if (testv_ra[index] === 5'bx) begin 
				$display("%d tests completed with %d errors",index, errors);
				// $finish;
				$stop;
			end
		end
endmodule