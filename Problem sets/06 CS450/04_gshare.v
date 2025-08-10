module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    
    reg [1:0] pht [0:127];
    
    wire [6:0] train_addr, predict_addr;
    reg [6:0] ghr;
    
    assign train_addr = train_history ^ train_pc;
    
    
    always @(posedge clk, posedge areset) begin
        if(areset) begin
            integer i;
            for (i=0; i<128; i=i+1)
                pht[i] <= 2'b01;
        end
        else begin
            if(train_valid) begin
                case(pht[train_addr])
                    2'b00: pht[train_addr] <= (train_taken) ? 2'b01 : 2'b00;
                    2'b01: pht[train_addr] <= (train_taken) ? 2'b10 : 2'b00;
                    2'b10: pht[train_addr] <= (train_taken) ? 2'b11 : 2'b01;
                    2'b11: pht[train_addr] <= (train_taken) ? 2'b11 : 2'b10;
                    default: pht[train_addr] <= pht[train_addr];
                endcase
            end
        end
    end
    
    
    always @(posedge clk, posedge areset) begin
        if(areset) ghr <= 7'd0;
        else begin
            if(train_valid & train_mispredicted) ghr <= {train_history[5:0], train_taken};
            else if(predict_valid) ghr <= {ghr[5:0], predict_taken};
            else ghr <= ghr;
        end
    end
    
    
    assign predict_addr = ghr ^ predict_pc;

    
    assign predict_taken = pht[predict_addr][1];
    
    assign predict_history = ghr;

endmodule
