module mod_cu(
    input clk,
    input reset,
    output reg start,
    output reg subtract,
    output reg check_less_than,
    input done
);

// FSM state encoding
parameter INIT = 2'b00, SUBTRACT = 2'b01, COMP = 2'b10, DONE = 2'b11;
reg [1:0] state = INIT;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= INIT;
        start <= 0;
        subtract <= 0;
        check_less_than <= 0;
       
    end else begin
        case (state)
            INIT: begin
                start <= 1;
                state <= SUBTRACT;
            end
            SUBTRACT: begin
                start <= 0;
                subtract <= 1;
                if (done) begin
                    subtract <= 0;
                    check_less_than <= 1;
                    state <= COMP;
                end
            end
            COMP: begin
                check_less_than <= 0;
                if (done) begin
                    state <= DONE;
                end else begin
                    state <= SUBTRACT;
                end
            end
            DONE: begin
                // Remain in DONE state until reset
            end
            default: begin
                state <= INIT;
            end
        endcase
    end
end

endmodule
