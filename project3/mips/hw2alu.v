module memop(output [31:0] content)
	
	reg [31:0] registers [31:0];
	
	initial begin
	#readmemb("register.mem",registers);
	content=registers[0];
	end

endmodule