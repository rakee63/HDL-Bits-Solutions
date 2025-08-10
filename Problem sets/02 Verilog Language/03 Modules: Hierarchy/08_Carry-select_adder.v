module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire carry;
    wire [15:0] sum0, sum1;
    add16 i1 (.a(a[15:0]), .b(b[15:0]), .cin(1'b0), .sum(sum[15:0]), .cout(carry));
    add16 i2 (.a(a[31:16]), .b(b[31:16]), .cin(1'b0), .sum(sum0));
    add16 i3 (.a(a[31:16]), .b(b[31:16]), .cin(1'b1), .sum(sum1));
    
    always @(*) begin
        case (carry)
            1'b0: sum[31:16] = sum0;
            1'b1: sum[31:16] = sum1;
        endcase
    end
endmodule
