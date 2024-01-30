

module mod_dp(
    input clk,
    input reset,
    input start,
    input [31:0] A,
    input [31:0] B,
    output reg [31:0] result,
    output reg done,// Coming from the control unit
    input subtract,         // Control signal to perform subtraction
    input check_less_than,  // Control signal to check if A is less than B
    output ALU_done
);

reg [31:0]  current_A;
wire [31:0] alu_result2;
reg operation_done;
wire [31:0] alu_result;
wire alu_cout;
wire alu_lt;

    reg [2:0] sub = 3'b110;
    reg [2:0] lt = 3'b100;
// Instantiate your ALU here
alu_32bit alu2 (
        .A(current_A),
        .B(B),
        .realres(alu_result),
        .cout(alu_cout),                  // Not used, assuming ALU does not have a carry out
        .S(sub)                   // Operation code for subtraction
    );

    // ALU for less than. If current_A is less than B realress will be 32 bit number but lsn(least significant number will be 1)
    alu_32bit alu1 (
        .A(current_A),
        .B(B),
        .realres(alu_result2),
        .cout(),                  // Not used, assuming ALU does not have a carry out
        .S(lt)                   // Operation code for subtraction
    );
    
    // This AND gate is to check if the least significant bit of the less_than1 is set
    and and1(alu_lt, 1'b1, alu_result2[0]);


always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_A <= A;
        //operation_done <= 0;
        done <= 0;
    end else if (start) begin
        current_A <= A; // Load A
       // operation_done <= 0;
    end else if (subtract) begin
			if(!alu_lt)begin
				current_A <= alu_result; 
		  end
    end else if (check_less_than) begin
       // operation_done <= alu_lt; 
        if (alu_lt) begin
            result <= current_A; 
            done <= 1;
        end
    end
end

assign ALU_out = alu_result;
assign ALU_done = alu_lt;

endmodule

