module top_module (
    input clk,
    input x,
    output z
); 
    wire p, q, qb, r, rb, a, b, c;
    initial begin
        p = 0;
        q = 0;
        qb = 1;
        r = 0;
        rb = 1;
    end
    always @(*) begin
    	a = x ^ p;
    	b = x & qb;
    	c = x | rb;
    	z = ~(p | q | r);
    end
    
    always @(posedge clk) begin
        p <= a;
    	q <= b;
    	qb <= ~b;
    	r <= c;
    	rb <= ~c;
    end
    
endmodule
