module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    reg grid [0:15][0:15];         // 16x16 bit grid
    reg next_grid [0:15][0:15];

    integer i, j, k;
    reg [4:0] sum;                 // Can go up to 8

    // Load or update q on clock
    always @(posedge clk) begin
        if (load) begin
            // Load data into grid
            for (i = 0; i < 16; i = i + 1)
                for (j = 0; j < 16; j = j + 1)
                    grid[i][j] <= data[i*16 + j];
        end else begin
            for (i = 0; i < 16; i = i + 1)
                for (j = 0; j < 16; j = j + 1)
                    grid[i][j] <= next_grid[i][j];
        end
    end
    
    always @(*) begin
		// Pack grid into q
        for (i = 0; i < 16; i = i + 1)
            for (j = 0; j < 16; j = j + 1)
                q[i*16 + j] <= grid[i][j];
    end

    // Combinational logic for next state
    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                sum = grid[i][(j+15)%16] + grid[i][(j+1)%16] +
                      grid[(i+15)%16][j] + grid[(i+1)%16][j] +
                      grid[(i+15)%16][(j+15)%16] + grid[(i+15)%16][(j+1)%16] +
                      grid[(i+1)%16][(j+15)%16] + grid[(i+1)%16][(j+1)%16];
                case (sum)
                    5'd2: next_grid[i][j] = grid[i][j];
                    5'd3: next_grid[i][j] = 1;
                    default: next_grid[i][j] = 0;
                endcase
            end
        end
    end

endmodule
