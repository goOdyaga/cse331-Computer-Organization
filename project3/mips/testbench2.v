module testbench2();

    reg clk;
    // Other signal declarations (unused in this testbench but included as per your original module)
    reg  [31:0] pc;
    wire [31:0] pc1;
    wire [31:0] pc2;
    wire [31:0] pc3;
    wire [31:0] pc4;
    wire [31:0] instructi;
    wire [2:0] ins;
    wire [2:0] ins1;
    wire [4:0] write_registe;
    wire alsrc;
	  wire zerob;

    // Instantiate the MIPS module
   fivebitmux  as(.a(5'b00000),.b(5'b00000), .select(1'b1),.realres(write_registe));

    // Clock generation
    initial begin
        clk = 0;
        forever #30 clk = ~clk; // Clock with a period of 60 units (30 high, 30 low)
    end

    // Monitoring and finishing
    initial begin
	 #5
	 //pc=32'b00000000000000000000000000000011;
        // Using $monitor to continuously monitor changes
        $monitor("%b\n",  write_registe);

        // Delaying the simulation end to allow for multiple cycles
       // #300; // Adjust this value as needed for your test
        //$finish();
    end
endmodule
