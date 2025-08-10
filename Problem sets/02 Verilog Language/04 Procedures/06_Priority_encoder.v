// synthesis verilog_input_version verilog_2001
module top_module (
    input [3:0] in,
    output reg [1:0] pos  );
    always @(*) begin
        case (in[0])
            1: pos = 2'd0;
            0: begin
                case (in[1])
                    1: pos = 2'd1;
                    0: begin
                        case (in[2])
                            1: pos = 2'd2;
                            0: begin
                                case(in[3])
                                    1: pos = 2'd3;
                                    0: pos = 2'd0;
                                endcase
                            end
                        endcase
                    end
                endcase
            end
        endcase
    end
endmodule
