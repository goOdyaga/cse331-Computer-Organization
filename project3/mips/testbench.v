module testbench();

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
    mips mps1(.clock(clk));

    // Clock generation
    initial begin
        clk = 0;
        forever #50 clk = ~clk; // Clock with a period of 60 units (30 high, 30 low)
    end

    // Monitoring and finishing
    
endmodule
