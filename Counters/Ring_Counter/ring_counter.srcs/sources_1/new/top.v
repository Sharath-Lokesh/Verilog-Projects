module ring_counter_4bit_msb (
    input clk,
    input rst_n, // Active low reset
    output reg [3:0] q
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin 
            q <= 4'b1000; // Initialize with MSB set to 1
        end else begin 
            {q[2:0], q[3]} <= q; 
        end 
    end
endmodule