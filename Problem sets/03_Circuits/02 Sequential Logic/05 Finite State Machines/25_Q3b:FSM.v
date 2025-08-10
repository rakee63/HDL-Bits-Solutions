module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    reg [2:0] state, next_state;
    
    always @(posedge clk) begin
        if(reset) state <= 3'b000;
        else state <= next_state;
    end
    
    always @(*) begin
        case(state)
            3'b000: next_state = (x) ? 3'b001 : 3'b000;
            3'b001: next_state = (x) ? 3'b100 : 3'b001;
            3'b010: next_state = (x) ? 3'b001 : 3'b010;
            3'b011: next_state = (x) ? 3'b010 : 3'b001;
            3'b100: next_state = (x) ? 3'b100 : 3'b011;
            default: next_state = 3'b000;
        endcase
    end
    
    assign z = state[2] | (state[1]&state[0]);

endmodule
