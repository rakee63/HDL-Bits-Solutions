module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 
    reg [511:0] A, B, C;
    always @(*) begin
        A = {1'b0, q[511:1]};
        B = q;
        C = {q[510:0], 1'b0};
    end
    always @(posedge clk) begin
        if(load) q <= data;
        else q <= ((~A)&(B|C)) | (B^C);
    end
endmodule
