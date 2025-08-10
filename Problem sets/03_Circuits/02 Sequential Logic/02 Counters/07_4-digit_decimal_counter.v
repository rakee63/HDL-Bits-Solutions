module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    always @(posedge clk) begin
        if(reset == 1) begin
            q <= 16'd0;
            ena <= 3'd0;
        end
        else begin
            ena[1] <= (q[3:0] == 4'd8);
            ena[2] <= (q[3:0] == 4'd8) && (q[7:4] == 4'd9);
            ena[3] <= (q[3:0] == 4'd8) && (q[7:4] == 4'd9) && (q[11:8] == 4'd9);
            
            q[3:0] <= (q[3:0] == 4'd9) ? 4'd0 : q[3:0]+1;
            
            if(q[3:0]==4'd9) begin
                if(q[7:4]==4'd9) q[7:4] <= 4'd0;
                else q[7:4] <= q[7:4]+1;
            end
            else q[7:4] <= q[7:4];
            
            if(q[7:4]==4'd9 && q[3:0]==4'd9) begin
                if(q[11:8]==4'd9) q[11:8] <= 4'd0;
                else q[11:8] <= q[11:8]+1;
            end
            else q[11:8] <= q[11:8];
            
            if(q[11:8]==4'd9 && q[7:4]==4'd9 && q[3:0]==4'd9) begin
                if(q[15:12]==4'd9) q[15:12] <= 4'd0;
                else q[15:12] <= q[15:12]+1;
            end
            else q[15:12] <= q[15:12];
            
            
        end
    end
endmodule
