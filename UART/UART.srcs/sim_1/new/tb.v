`timescale 1ns / 1ps

module tb();
    reg clk = 0;
    reg start_1 = 0, start_2 = 0;
    reg [7:0] txin_1 = 0, txin_2 = 0;
    wire tx;
    wire rx;
    wire [7:0] rxout_1, rxout_2;
    wire rxdone_1, rxdone_2, txdone_1, txdone_2;
    
    uart dev1(clk, start_1, txin_1, tx, rx, rxout_1, rxdone_1, txdone_1);
    uart dev2(clk, start_2, txin_2, rx, tx, rxout_2, rxdone_2, txdone_2);
    
    initial begin
        start_1 = 1;
        start_2 = 1;
        txin_1 = 8'hAB;
        txin_2 = 8'hCD;
        @(posedge txdone_1);
        @(posedge rxdone_2);
        @(posedge txdone_2);
        @(posedge rxdone_1);
    end
    
    // 100 MHz clk
    always #5 clk = ~clk;
    
endmodule