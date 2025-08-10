module top_module (input x, input y, output z);
    wire a1, a2, b1, b2;
    AB block1 (x, y, a1, b1);
    AB block2 (x, y, a2, b2);
    assign z = (a1 | b1) ^ (a2 & b2);
endmodule

module AB (input x, input y, output z1, output z2);
    assign z1 = x & (~y);
    assign z2 = ~(x ^ y);
endmodule
