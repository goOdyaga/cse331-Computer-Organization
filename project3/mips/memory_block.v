module memory_block (
 output reg [31:0] read_data,
 input byteOperations,
 input [17:0] address,
 input [31:0] write_data,
 input memRead,
 input memWrite);
 
 reg [31:0] registers [31:0];



	always @(*) begin
	
	 $readmemb("memory.mem", registers); // Read file at the beginning
		
	
		 if (memWrite & !byteOperations) begin
				registers[address]=write_data;
		 end
		 
		 if (memWrite & byteOperations) begin
				registers[address][7:0]=write_data[7:0];
		 end
		 
	
		 
		 if (memRead & !byteOperations) begin
			read_data=registers[address];
		 end
		
		 if (memRead & byteOperations) begin
			read_data=registers[address];
			read_data=read_data &  32'h000000FF;
		 end
		
		
		$writememb("memory.mem",registers);
	end

endmodule
