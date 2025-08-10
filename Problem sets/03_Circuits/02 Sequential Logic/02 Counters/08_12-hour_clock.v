module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss);
    reg [7:0] out1, out2, out3;
    bcd_add add1 (ss, out1);
    bcd_add add2 (mm, out2);
    bcd_add add3 (hh, out3);
    always @(posedge clk) begin
        if(reset) begin
            pm <= 0;
            hh <= 8'h12;
            mm <= 8'h00;
            ss <= 8'h00;
        end
        else begin
            if(ena==1) begin
                if(ss==8'h59) ss <= 8'h00;
                else ss <= out1;
            end
            else ss <= ss;
            
            if(ss==8'h59 && ena==1) begin
                if(mm == 8'h59) mm <= 8'h00;
                else mm <= out2;
            end
            else mm <= mm;
            
            if(ss==8'h59 && mm==8'h59 && ena==1) begin
                if(hh == 8'h12) hh <= 8'h01;
                else hh <= out3;
            end
            else hh <= hh;
            
            if(ss==8'h59 && mm==8'h59 && hh==8'h11 &&  ena==1) pm <= ~pm;
            else pm <= pm;
        end
    end
endmodule

module bcd_add (input [7:0] in, output [7:0] out);
    always @(*) begin
        if(in[3:0]==4'd9) begin
            out[3:0] <= 4'h0;
            out[7:4] <= in[7:4]+1;
        end
        else out <= in+1;
    end
endmodule
