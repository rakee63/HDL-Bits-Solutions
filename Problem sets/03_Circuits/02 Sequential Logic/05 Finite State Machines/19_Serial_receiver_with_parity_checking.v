module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //
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
    			L = 12,
    			M = 13;
    reg [3:0] state, next_state;
    reg [7:0] in_byte;
    reg in_prev, in_prev_prev;
    reg oddp;
    wire odd;
    
    parity parity_check (clk, (next_state == B), in, oddp);
    // Modify FSM and datapath from Fsm_serialdata

    // New: Add parity checking.
    always @(posedge clk) begin
        if(reset) state <= A;
        else state <= next_state;
        
        in_prev <= in;
        in_prev_prev <= in_prev;
        in_byte <= {in_prev_prev, in_byte[7:1]};
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
            J: next_state = K;
            K: next_state = (in) ? L : M;
            L: next_state = (in) ? A : B;
            M: next_state = (in) ? A : M;
            default: next_state = A;
        endcase
    end
    
    assign odd = (state==K) ? oddp : odd;
    assign done = (state == L)&(odd);
    // Use FSM from Fsm_serial

    // New: Datapath to latch input bits.
    always @(*) begin
        if(done) out_byte = in_byte;
        else out_byte = 8'd0;
    end

endmodule
