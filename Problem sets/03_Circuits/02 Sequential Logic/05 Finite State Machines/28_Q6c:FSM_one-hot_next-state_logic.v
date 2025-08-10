module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);

    always @(*) begin
        if(w) begin
            if(y[2] | y[3] | y[5] | y[6]) Y4 = 1;
            else Y4 = 0;
        end
        else Y4 = 0;
    end
    
    always @(*) begin
        if(~w & y[1]) Y2 = 1;
        else Y2 = 0;
    end
    
endmodule
