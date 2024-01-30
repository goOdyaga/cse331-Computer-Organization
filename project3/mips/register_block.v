module register_block(
	output reg [31:0] read_data1,
	output reg [31:0] read_data2,
	input [31:0] write_data,
	input [4:0] read_reg1,
	input [4:0] read_reg2,
	input [4:0] write_reg,
	input regWrite
);
	reg [31:0] registers [31:0]; // this is going hold my register file
	
	always @(*) begin
	//$display("You are in here!\n");
	$readmemb("registers.mem", registers);
			// write the data to the register if regWrite == 1
		  
		  
		  // determine outputs of the register block
		  read_data1 = registers[read_reg1];
		  read_data2 = registers[read_reg2];
		  //$monitor("=> %b\n",read_reg2);
		 //#1
		 if (regWrite & write_reg != 5'b0) begin
			if(read_reg1==write_reg  ) begin
					registers[write_reg] = write_data;
					//#50;
					$writememb("registers.mem", registers);
					
			end
		   // put write_data into the register
				else begin 
				registers[write_reg] = write_data;
				$writememb("registers.mem", registers); // write back to the file
				end
				end
		 // $stop;
		  end
endmodule