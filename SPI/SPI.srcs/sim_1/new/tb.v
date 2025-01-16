`timescale 1ns / 1ps

module spi_tb(
    
    );
    
    reg clk = 0;              // system clk
    reg [11:0] din = 12'habc;       // 12 bit data
    reg start_tx = 0;            // start mosi tx
    reg start_rx = 0;            // start miso rx
    
    wire  cs;          // chip select active low
    wire  mosi_miso;        // mosi channel
    wire sclk;             // sclk for slave
    wire [11:0] dout;     // output register to see the miso data
    wire  tx_done, rx_done;
    
    spi dut (clk, din, start_tx, start_rx, cs, mosi_miso, mosi_miso, sclk, dout, tx_done, rx_done);
    always #5 clk = ~clk;
    
    initial begin
        start_tx = 1;
        start_rx = 1;
        @(posedge tx_done);
        @(posedge rx_done);
        
        start_rx = 0;
        din = 12'h123;
        @(posedge tx_done);
        
        din = 12'h89a;
        start_rx = 1;
        @(posedge tx_done);
        @(posedge rx_done);
    end
endmodule
