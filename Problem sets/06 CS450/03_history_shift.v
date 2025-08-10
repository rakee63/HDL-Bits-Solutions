module top_module(
    input clk,
    input areset,

    input predict_valid,
    input predict_taken,
    output [31:0] predict_history,

    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);
    
    reg [31:0] next_predict_history;
    
    always @(posedge clk, posedge areset) begin
        if(areset) predict_history <= 32'd0;
        else predict_history <= next_predict_history;
    end
    
    always @(*) begin
        if(train_mispredicted) next_predict_history = {train_history[30:0], train_taken};
        else if(predict_valid) next_predict_history = {predict_history[30:0], predict_taken};
        else next_predict_history = predict_history;
    end

endmodule
