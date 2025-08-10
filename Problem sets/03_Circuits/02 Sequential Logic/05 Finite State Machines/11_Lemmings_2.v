module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    parameter [1:0] A=0,	//LEFT
    				B=1,	//RIGHT
    				C=2,	//FALL (prev state left)
    				D=3;	//FALL (prev state right)
    reg [1:0] state, next_state;
    
    always @(posedge clk, posedge areset) begin
        if(areset) state <= A;
        else state <= next_state;
    end
    
    always @(*) begin
        case(state)
            A: {walk_left, walk_right, aaah} = 3'b100;
            B: {walk_left, walk_right, aaah} = 3'b010;
            C: {walk_left, walk_right, aaah} = 3'b001;
            D: {walk_left, walk_right, aaah} = 3'b001;
        endcase
        
        case(state)
            A: casez({bump_left, bump_right, ground})
                3'bzz0: next_state = C;
                3'b101: next_state = B;
                3'b011: next_state = A;
                3'b111: next_state = B;
                3'b001: next_state = A;
            endcase
           // A: next_state = (ground) ? C : (bump_left) ? B : A;
            B: casez({bump_left, bump_right, ground})
                3'bzz0: next_state = D;
                3'b101: next_state = B;
                3'b011: next_state = A;
                3'b111: next_state = A;
                3'b001: next_state = B;
            endcase
            C: next_state = (ground) ? A : C;
            D: next_state = (ground) ? B : D;
            default: next_state = 3'bxxx;
        endcase
    end
    
endmodule
