module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire [31:0] bin;
    wire carry;
    
    always @(*) begin
    case (sub)
        1'b0: bin = b;
        1'b1: bin = ~b;
    endcase
    end
    
    add16 i1 (.a(a[15:0]), .b(bin[15:0]), .cin(sub), .sum(sum[15:0]), .cout(carry));
    add16 i2 (.a(a[31:16]), .b(bin[31:16]), .cin(carry), .sum(sum[31:16]));
endmodule
