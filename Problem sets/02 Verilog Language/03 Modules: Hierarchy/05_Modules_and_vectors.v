module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    wire [7:0] q1, q2, q3;
    my_dff8 i1 (.clk(clk), .d(d), .q(q1));
    my_dff8 i2 (.clk(clk), .d(q1), .q(q2));
    my_dff8 i3 (.clk(clk), .d(q2), .q(q3));
        assign q[0] = ((~sel[1])&(~sel[0])&(d[0])) | ((~sel[1])&(sel[0])&(q1[0])) | ((sel[1])&(~sel[0])&(q2[0])) | ((sel[1])&(sel[0])&(q3[0]));
        assign q[1] = ((~sel[1])&(~sel[0])&(d[1])) | ((~sel[1])&(sel[0])&(q1[1])) | ((sel[1])&(~sel[0])&(q2[1])) | ((sel[1])&(sel[0])&(q3[1]));
        assign q[2] = ((~sel[1])&(~sel[0])&(d[2])) | ((~sel[1])&(sel[0])&(q1[2])) | ((sel[1])&(~sel[0])&(q2[2])) | ((sel[1])&(sel[0])&(q3[2]));
        assign q[3] = ((~sel[1])&(~sel[0])&(d[3])) | ((~sel[1])&(sel[0])&(q1[3])) | ((sel[1])&(~sel[0])&(q2[3])) | ((sel[1])&(sel[0])&(q3[3]));
        assign q[4] = ((~sel[1])&(~sel[0])&(d[4])) | ((~sel[1])&(sel[0])&(q1[4])) | ((sel[1])&(~sel[0])&(q2[4])) | ((sel[1])&(sel[0])&(q3[4]));
        assign q[5] = ((~sel[1])&(~sel[0])&(d[5])) | ((~sel[1])&(sel[0])&(q1[5])) | ((sel[1])&(~sel[0])&(q2[5])) | ((sel[1])&(sel[0])&(q3[5]));
        assign q[6] = ((~sel[1])&(~sel[0])&(d[6])) | ((~sel[1])&(sel[0])&(q1[6])) | ((sel[1])&(~sel[0])&(q2[6])) | ((sel[1])&(sel[0])&(q3[6]));
        assign q[7] = ((~sel[1])&(~sel[0])&(d[7])) | ((~sel[1])&(sel[0])&(q1[7])) | ((sel[1])&(~sel[0])&(q2[7])) | ((sel[1])&(sel[0])&(q3[7]));

endmodule
