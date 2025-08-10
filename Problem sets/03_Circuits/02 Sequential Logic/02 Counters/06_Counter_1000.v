module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //
    reg [3:0] hz_100, hz_10, a;
    bcdcount counter0 (clk, reset, c_enable[0], hz_100);
    bcdcount counter1 (clk, reset, c_enable[1], hz_10);
    bcdcount counter2 (clk, reset, c_enable[2], a);
    assign c_enable[0] = 1;
    assign c_enable[1] = c_enable[0] & hz_100[3] & hz_100[0];
    assign c_enable[2] = c_enable[1] & hz_10[3] & hz_10[0];
    assign OneHertz = c_enable[2] & a[3] & a[0];

endmodule
