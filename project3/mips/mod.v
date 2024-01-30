module mod(
    input clk,
    input reset,
    input [31:0] A,
    input [31:0] B,
    output [31:0] result,
    output done
);

wire start;
wire subtract;
wire check_less_than;
wire ALU_done;

mod_cu control_unit(
    .clk(clk),
    .reset(reset),
    .start(start),
    .subtract(subtract),
    .check_less_than(check_less_than),
    .done(ALU_done)
);

mod_dp datapath(
    .clk(clk),
    .reset(reset),
    .start(start),
    .A(A),
    .B(B),
    .result(result),
    .done(done),
    .subtract(subtract),
    .check_less_than(check_less_than),
    .ALU_done(ALU_done)
);

endmodule
