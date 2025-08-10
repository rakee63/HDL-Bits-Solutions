module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] in_prev;
    always @(posedge clk) begin
        out <= ((in_prev & (~in)) | out)&({32{~reset}});
        in_prev <= in;
    end
endmodule
