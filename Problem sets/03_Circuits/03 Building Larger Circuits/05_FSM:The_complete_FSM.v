module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );

    parameter A=3'd0, B=3'd1, C=3'd2, D=3'd3, E=3'd4, F=3'd5, G=3'd6;
    
    reg [2:0] state, next_state;
    
    reg [1:0] cnt;
    
    always @(posedge clk) begin
        if(reset) state <= A;
        else state <= next_state;
    end
    
    always @(posedge clk) begin
        case(state)
            E: cnt <= cnt + 1;
            default: cnt <= 0;
        endcase
    end
    
    always @(*) begin
        case(state)
            A: next_state = (data) ? B : A;
            B: next_state = (data) ? C : A;
            C: next_state = (data) ? C : D;
            D: next_state = (data) ? E : A;
            E: next_state = (cnt==2'd3) ? F : E;
            F: next_state = (done_counting) ? G : F;
            G: next_state = (ack) ? A : G;
            default: next_state = A;
        endcase
    end
    
    assign shift_ena = (state==E);
    assign counting = (state==F);
    assign done = (state==G);
    
endmodule
