module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
	
    reg [3:0] gl;
    
    always @(posedge clk) begin
        if(~resetn) gl[0] <= 1;
        else begin
            gl[0] <= (r==3'b000) || (gl[1]&(~r[1])) || (gl[2]&(~r[2])) || (gl[3]&(~r[3]));
        end
    end
    
    always @(posedge clk) begin
        if(~resetn) gl[1] <= 0;
        else begin
            gl[1] <= (gl[0]&r[1]) | (gl[1]&r[1]);
        end
    end
    
    always @(posedge clk) begin
        if(~resetn) gl[2] <= 0;
        else begin
            gl[2] <= (gl[0]&(~r[1])&r[2]) | (gl[2]&r[2]);
        end
    end
    
    always @(posedge clk) begin
        if(~resetn) gl[3] <= 0;
        else begin
            gl[3] <= (gl[0]&(~r[1])&(~r[2])&r[3]) | (gl[3]&r[3]);
        end
    end
    
    assign g = gl[3:1];
endmodule
