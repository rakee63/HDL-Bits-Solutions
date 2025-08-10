module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    parameter [2:0] A=0,	//walking left
    				B=1,	//walking right
    				C=2,	//fall with previously walk left
    				D=3,	//fall with previously walk right
    				E=4,	//dig with previously walk left
    				F=5;	//dig with previously walk right
    reg [2:0] state, next_state;
    
    always @(posedge clk, posedge areset) begin
        if(areset) state <= A;
        else state <= next_state;
    end
    
    always @(*) begin
        case(state)
            A: {walk_left, walk_right, aaah, digging} = 4'b1000;
            B: {walk_left, walk_right, aaah, digging} = 4'b0100;
            C: {walk_left, walk_right, aaah, digging} = 4'b0010;
            D: {walk_left, walk_right, aaah, digging} = 4'b0010;
            E: {walk_left, walk_right, aaah, digging} = 4'b0001;
            F: {walk_left, walk_right, aaah, digging} = 4'b0001;
        endcase
        
        case(state)
            A: casez({bump_left, bump_right, dig, ground})
                4'bzzz0: next_state = C;
                4'bzz11: next_state = E;
                4'b0z01: next_state = A;
                4'b1z01: next_state = B;
            endcase
            B: casez({bump_left, bump_right, dig, ground})
                4'bzzz0: next_state = D;
                4'bzz11: next_state = F;
                4'bz001: next_state = B;
                4'bz101: next_state = A;
            endcase
            C: next_state = (ground) ? A : C;
            D: next_state = (ground) ? B : D;
            E: next_state = (ground) ? E : C;
            F: next_state = (ground) ? F : D;
            default: next_state = A;
        endcase
    end
endmodule
