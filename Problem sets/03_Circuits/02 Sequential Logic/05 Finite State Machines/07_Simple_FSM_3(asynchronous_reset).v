module top_module(
    input clk,
    input in,
    input areset,
    output out); //
	parameter A=2'd00, B=2'd01, C=2'd10, D=2'd11;
    reg [1:0] state, nxt_state;
    // State transition logic
    always @(posedge clk, posedge areset) begin
        if(areset) nxt_state = A;
        else begin
            case(state)
                A: nxt_state = (in) ? B : A;
                B: nxt_state = (in) ? B : C;
                C: nxt_state = (in) ? D : A;
                D: nxt_state = (in) ? B : C;
            endcase
        end
        state = nxt_state;
    end
    // State flip-flops with asynchronous reset
    assign out = (state==D);
    // Output logic

endmodule
