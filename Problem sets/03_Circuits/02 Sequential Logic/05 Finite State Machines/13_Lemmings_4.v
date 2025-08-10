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
    				C=2,	//falling and prev wlaking left
    				D=3,	//falling and prev walking right
    				E=4,	//digging and prev walking left
    				F=5,	//digging and prev walking right
    				G=6;	//splatter
    reg [2:0] state, next_state;
    reg [7:0] count;
    
    always @(posedge clk, posedge areset) begin
        if(areset) begin
            state <= A;
            count <= 7'd0;
        end
        else begin
            state <= next_state;
            if(state==C || state==D) count <= count + 7'd1;
            else count <= 7'd0;
        end
    end
    
    always @(*) begin
        case(state)
            A: next_state = (ground) ? (dig) ? E : (bump_left) ? B : A : C;
            B: next_state = (ground) ? (dig) ? F : (bump_right) ? A : B : D;
            C: next_state = (ground) ? (count>7'd19) ? G : A : C;
            D: next_state = (ground) ? (count>7'd19) ? G : B : D;
            E: next_state = (ground) ? E : C;
            F: next_state = (ground) ? F : D;
            G: next_state = G;
        endcase
    end
    
    //always @(*) begin
	assign walk_left = (state==A);
	assign walk_right = (state==B);
	assign digging = (state==E || state==F);
	assign aaah = (state==C || state==D);
    //end
endmodule
