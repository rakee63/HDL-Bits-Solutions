module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
	parameter 	A = 0,
    			B = 1,
    			C = 2,
    			D = 3,
    			E = 4,
    			F = 5,
    			G = 6,
    			H = 7,
    			WAIT = 8,
    			DONE = 9;
    reg [3:0] state, next_state;
    
    always @(posedge clk) begin
        if(reset) state <= A;
        else state <= next_state;
    end
    
    always @(*) begin
        case(state)
            A: next_state = (s) ? B : A;
            B: next_state = (w) ? D : C;
            C: next_state = (w) ? F : E;
            D: next_state = (w) ? H : G;
            E: next_state = WAIT;
            F: next_state = (w) ? DONE : WAIT;
            G: next_state = (w) ? DONE : WAIT;
            H: next_state = (w) ? WAIT : DONE;
            WAIT: next_state = (w) ? D : C;
            DONE: next_state = (w) ? D : C;
            default: next_state = A;
        endcase
    end
    
    assign z = (state==DONE);
endmodule
