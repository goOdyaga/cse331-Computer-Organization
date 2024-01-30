module instruction_block (
 output reg [31:0] instruction,
 input [31:0] pc);
 
 
reg [31:0] registers [31:0];
reg [31:0] temp;
integer i;

	always @(*) begin
	
	 $readmemb("instructions.mem", registers); // Read file at the beginning
		
	instruction=registers[pc/4];

			
		 
	end



 endmodule
