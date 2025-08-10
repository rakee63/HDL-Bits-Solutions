module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

    parameter A=1'b0, B=1'b1;
    
    reg [1:0] cnt;
    reg state, next_state;
    
    always @(posedge clk) begin
        if(reset) state <= A;
        else state <= next_state;
    end
    
    always @(posedge clk) begin
        case(next_state)
            A: cnt = cnt + 1;
            B: cnt = 0;
        endcase
    end
    
    always @(*) begin
        case(state)
            A: next_state = (cnt==2'd3) ? B : A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end
    
    assign shift_ena = (state==A);
    
endmodule
