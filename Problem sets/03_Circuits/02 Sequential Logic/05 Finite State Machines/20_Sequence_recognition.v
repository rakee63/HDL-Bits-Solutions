module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
	parameter 	NONE = 0,
    			ONE = 1,
    			TWO = 2,
    			THREE = 3,
    			FOUR = 4,
    			FIVE = 5,
    			SIX = 6,
    			DISCARD = 7,
    			FLAG = 8,
    			ERROR = 9;
    reg [4:0] state, next_state;
    
    always @(posedge clk) begin
        if(reset) state <= NONE;
        else state <= next_state;
    end
    
    always @(*) begin
        case(state)
            NONE: next_state = (in) ? ONE : NONE;
            ONE: next_state = (in) ? TWO : NONE;
            TWO: next_state = (in) ? THREE : NONE;
            THREE: next_state = (in) ? FOUR : NONE;
            FOUR: next_state = (in) ? FIVE : NONE;
            FIVE: next_state = (in) ? SIX : DISCARD;
            SIX: next_state = (in) ? ERROR : FLAG;
            DISCARD: next_state = (in) ? ONE : NONE;
            FLAG: next_state = (in) ? ONE : NONE;
            ERROR: next_state = (in) ? ERROR : NONE;
            default: next_state = NONE;
        endcase
    end
    
    assign disc = (state==DISCARD);
    assign flag = (state==FLAG);
    assign err = (state==ERROR);
endmodule
