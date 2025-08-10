module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
    parameter A=0, B=1, C=2;
    
    reg [1:0] state, next_state;
    
    reg [9:0] count;
    
    always @(posedge clk) begin
        state <= next_state;
    end
    
    always @(*) begin
        case(state)
            A: next_state = (load) ? A : (count==10'd0) ? C : B;
            B: next_state = (load) ? A : (count==10'd0) ? C : B;
            C: next_state = (load) ? A : C;
            default: next_state = C;
        endcase
    end
    
    always @(posedge clk) begin
        case(next_state)
            A: count <= data;
            B: count <= count - 10'd1;
            default: count <= count;
        endcase
    end

    assign tc = (count==10'd0);
    
endmodule
