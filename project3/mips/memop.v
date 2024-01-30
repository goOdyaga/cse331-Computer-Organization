module memop(
    output reg [31:0] content, 
	 input [31:0] w, 
    input [4:0] address
);

    reg [31:0] registers [31:0];

    
    always @(address) begin
        // Read operation
		  $readmemb("registers.mem", registers);
        content = registers[address];
		  registers[address]=w;
		  $writememb("registers.mem", registers);

        
    end

   

endmodule
