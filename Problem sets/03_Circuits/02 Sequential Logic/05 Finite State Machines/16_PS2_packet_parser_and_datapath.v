module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
    parameter [1:0] A=0,	//no message byte
    				B=1,	//1st message byte
    				C=2,	//2nd message byte
    				D=3;	//3rd message byte
    reg [1:0] state, next_state;
    
    // State transition logic (combinational)
    always @(*) begin
        case(state)
            A: next_state = (in[3]) ? B : A;
            B: next_state = C;
            C: next_state = D;
            D: next_state = (in[3]) ? B : A;
            default: next_state = 2'bxx;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if(reset) state <= A;
        else state <= next_state;
    end
 
    // Output logic
    assign done = (state==D);
    

    // New: Datapath to store incoming bytes.
    always @(posedge clk) begin
        case(next_state)
            A: out_bytes = 24'hxxxxxx;
            D: out_bytes[7:0] = in;
            C: out_bytes[15:8] = in;
            B: out_bytes[23:16] = in;
        endcase
    end

endmodule
