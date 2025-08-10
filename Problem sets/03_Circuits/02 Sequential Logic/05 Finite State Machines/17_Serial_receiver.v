module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
);
    parameter 	A = 1,
    			B = 2,
    			C = 3,
    			D = 4,
    			E = 5,
    			F = 6,
    			G = 7,
    			H = 8,
    			I = 9,
    			J = 10,
    			K = 11,
    			L = 12;
    reg [3:0] state, next_state;
    
    always @(posedge clk) begin
        if(reset) state <= A;
        else state <= next_state;
    end
    
    always @(*) begin
        case(state)
            A: next_state = (in) ? A : B;
            B: next_state = C;
            C: next_state = D;
            D: next_state = E;
            E: next_state = F;
            F: next_state = G;
            G: next_state = H;
            H: next_state = I;
            I: next_state = J;
            J: next_state = (in) ? K : L;
            K: next_state = (in) ? A : B;
            L: next_state = (in) ? A : L;
            default: next_state = A;
        endcase
    end
    
    assign done = (state == K);

endmodule
