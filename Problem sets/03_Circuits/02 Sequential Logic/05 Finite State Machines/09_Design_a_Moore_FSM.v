module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    parameter [2:0] A1=3'd0, B0=3'd1, B1=3'd2, C0=3'd3, C1=3'd4, D0=3'd5;
    reg [2:0] state, next_state;
    
    always @(posedge clk) begin
        if(reset) state <= A1;
        else state <= next_state;
    end
    
    always @(*) begin
        case(state)
            A1: next_state = (s[1]) ? B0 : A1;
            B0: next_state = (s[2]) ? C0 : (s[1]) ? B0 : A1;
            B1: next_state = (s[2]) ? C0 : (s[1]) ? B1 : A1;
            C0: next_state = (s[3]) ? D0 : (s[2]) ? C0 : B1;
            C1: next_state = (s[3]) ? D0 : (s[2]) ? C1 : B1;
            D0: next_state = (s[3]) ? D0 : C1;
            default: next_state = 3'bxxx;
        endcase
        
        case(state)
            A1: {fr1, fr2, fr3, dfr} = 4'b1111;
            B0: {fr1, fr2, fr3, dfr} = 4'b1100;
            B1: {fr1, fr2, fr3, dfr} = 4'b1101;
            C0: {fr1, fr2, fr3, dfr} = 4'b1000;
            C1: {fr1, fr2, fr3, dfr} = 4'b1001;
            D0: {fr1, fr2, fr3, dfr} = 4'b0000;
            default: {fr1, fr2, fr3, dfr} = 4'bxxxx;
        endcase
    end
endmodule
