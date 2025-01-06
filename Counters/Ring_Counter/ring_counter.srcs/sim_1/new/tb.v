`timescale 1ns / 1ps

module tb();
    reg clk = 0, rst_n = 1; // Active low reset
    wire [3:0] q;
    ring_counter_4bit_msb dut(clk, rst_n, q);
    
    always #10 clk = ~clk;
    
    initial begin
        rst_n = 0;
        #50;
        rst_n = 1;
    end
endmodule
