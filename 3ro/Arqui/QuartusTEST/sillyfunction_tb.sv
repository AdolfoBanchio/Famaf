module sillyfunction_tb();
		logic a,b,c;
		logic y;
		
		sillyfunction dut(a,b,c,y);
		
		initial begin
		a=0; b=0;c=1;#50;		
		a=1;b=1;c=1;#10;
		end
		
endmodule