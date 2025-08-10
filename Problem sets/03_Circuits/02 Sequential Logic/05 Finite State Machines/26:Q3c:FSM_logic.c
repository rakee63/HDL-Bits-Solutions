module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    reg [2:0] state, next_state;
    
    always @(posedge clk) begin
        state <= next_state;
    end
    
    always @(*) begin
        case(y)
            3'b000: next_state = (x) ? 3'b001 : 3'b000;
            3'b001: next_state = (x) ? 3'b100 : 3'b001;
            3'b010: next_state = (x) ? 3'b001 : 3'b010;
            3'b011: next_state = (x) ? 3'b010 : 3'b001;
            3'b100: next_state = (x) ? 3'b100 : 3'b011;
            default: next_state = 3'b000;
        endcase
    end
    
    assign z = y[2] | (y[1]&y[0]);
    assign Y0 = next_state[0];
endmodule
