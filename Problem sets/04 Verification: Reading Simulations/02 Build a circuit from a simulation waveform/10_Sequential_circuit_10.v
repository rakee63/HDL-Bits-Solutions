module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    
    always @(posedge clk) begin
        case({a, b})
            2'b00: state <= 0;
            2'b11: state <= 1;
            default: state <= state;
        endcase
    end
    
    always @(*) begin
        if(state) q = a~^b;
        else q = a^b;
    end

endmodule
