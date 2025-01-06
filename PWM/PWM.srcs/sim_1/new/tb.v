`timescale 1ns / 1ps

module tb(

    );
    reg clk = 0;
    reg rstn = 0;
    wire dout;
    
    always #5 clk = ~clk;
    
    pwm dut (clk, rstn, dout);
    initial begin
        rstn = 0;
        #40;
        rstn = 1;
    end
endmodule
