module top_module (
    input clk,
    input d,
    output q
);
    wire q1, q2;
    always @(posedge clk) begin
        q1 <= d;
    end
    always @(negedge clk) begin
        q2 <= d;
    end
    assign q = (q1 & clk) | (q2 & (~clk));
endmodule
