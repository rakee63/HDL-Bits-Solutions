module top_module( 
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor 
);
    always @(*) begin
        out_and = & in[99:0];
        out_or = | in[99:0];
        out_xor = ^ in[99:0];
    end

endmodule
