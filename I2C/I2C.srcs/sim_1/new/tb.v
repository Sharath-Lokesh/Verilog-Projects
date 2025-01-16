`timescale 1ns / 1ps

module tb();

    reg clk = 0;
    reg rstn = 0;
    reg ack;
    reg enable; // begin the i2c operation
    reg rw;
    reg [7:0] wdata;
    reg [6:0] addr;
    wire [7:0] rdata;
    wire done;   
    wire scl;
    
    wire _sda;
    
    i2c dut(clk, rstn, ack, enable, rw, wdata, addr, rdata, done, scl, _sda);
    
    
  //i2c dut (clk, rstn, enable, ack, wr, scl, _sda, wdata, addr, rdata, done);
    initial begin
        rstn = 0;
        #50; 
        rstn = 1;
    end
    
    always #5 clk = ~clk;
    
    reg sclk = 0;
    parameter clk_div = 1_000_000 / 400_000;
    integer count = 0, i=0;
    
    always @(posedge clk) begin : generate_slow_clk
        if (count < clk_div / 2) count <= count + 1;
        else begin
            count <= 0;
            sclk <= ~sclk;
        end
    end
    
    initial begin
        // write operation
        rw = 0;
        addr = 7'h4b;
        wdata = 8'hcd;
        enable = 1;
        ack = 0;
        wait(done);
        
//        read
        rw = 1;
        addr = 7'h4b;
        enable = 1;
        ack = 1;
    end
endmodule
