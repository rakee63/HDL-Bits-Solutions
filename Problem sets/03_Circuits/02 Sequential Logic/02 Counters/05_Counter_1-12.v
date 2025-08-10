module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
);
    count4 the_counter (clk, c_enable, c_load, c_d, Q);
    always @(*) begin
        c_enable = enable;
        //c_load = (enable) ? reset | (Q == 4'hc) : 0;
        if(reset) c_load = 1;
        else c_load = (enable & (Q == 4'hc)) ? 1 : 0;
        if(c_load) c_d = 4'd1;
        else c_d = 4'd0;
    end

endmodule
