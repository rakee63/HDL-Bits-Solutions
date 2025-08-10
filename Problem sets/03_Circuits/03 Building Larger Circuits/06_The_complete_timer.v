module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    //controlpath
    parameter A=3'd0, B=3'd1, C=3'd2, D=3'd3, E=3'd4, F=3'd5, G=3'd6;
    
    reg [2:0] state, next_state;
    reg [1:0] cnt;
    wire shift_ena, done_counting;
    
    always @(posedge clk) begin
        if(reset) state <= A;
        else state <= next_state;
    end
    
    always @(posedge clk) begin
        if(reset) cnt <= 2'd0;
        case(state)
            E: cnt <= cnt + 2'd1;
            default: cnt <= 2'd0;
        endcase
    end
    
    always @(*) begin
        case(state)
            A: next_state = (data) ? B : A;
            B: next_state = (data) ? C : A;
            C: next_state = (data) ? C : D;
            D: next_state = (data) ? E : A;
            E: next_state = (cnt==2'd3) ? F : E;
            F: next_state = (done_counting) ? G : F;
            G: next_state = (ack) ? A : G;
            default: next_state = A;
        endcase
    end
    
    assign shift_ena = (state==E);
    assign counting = (state==F);
    assign done = (state==G);
    assign done_counting = (count==4'd0)&&(cycles==10'd999);
    
    
    //datapath
    reg [9:0] cycles;
    
    always @(posedge clk) begin
        if(reset) cycles <= 10'd0;
        else begin
            case(state)
                F: cycles <= (cycles==10'd999) ? 10'd0 : cycles + 10'd1;
                default: cycles <= 10'd0;
            endcase
        end
    end
    
    always @(posedge clk) begin
        if(reset) count <= 4'd0;
        else begin
            case(state)
                E: count <= {count[2:0], data};
                F: count <= (cycles==10'd999) ? count - 4'd1 : count;
                default: count <= 4'd0;
            endcase
        end
    end

endmodule
