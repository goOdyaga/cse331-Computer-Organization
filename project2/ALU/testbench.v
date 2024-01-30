// Testbench
module testbench;
    reg [3:0] a, b;
    reg c_in;
    wire [3:0] sum;

    // Instantiate the 4-bit full adder
    full_adder_4bit adder(sum, a, b, c_in);

    initial begin
        // Initialize inputs
        a = 4'b0000;  // Example value
        b = 4'b0000;  // Example value
        c_in = 1'b1;  // No carry input for the first addition

        // Monitor the output
        $monitor("Time = %d : a = %b, b = %b sum = %b", $time, a, b, sum);

        // Provide different test inputs
        #10 a = 4'b0101; b = 4'b0011;  // Example: Add 5 and 3
        #10 a = -7; b = -6;  // Example: Add -7 and 6 (using two's complement for -7)
        // Add more test cases as needed

       // #20 $finish;
    end
endmodule
