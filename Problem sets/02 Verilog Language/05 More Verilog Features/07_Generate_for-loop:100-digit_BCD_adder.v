module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    wire [99:0] carry;
    bcd_fadd bf_0 (a[3:0], b[3:0], cin, carry[0], sum[3:0]);
    genvar i;
    generate
        for(i=1; i<100; i++) begin : bcd_adders
            bcd_fadd bf (a[(4*i)+3:4*i], b[(4*i)+3:4*i], carry[i-1], carry[i], sum[(4*i)+3:4*i]);
        end
    endgenerate
    assign cout = carry[99];
endmodule
