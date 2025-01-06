`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sharath Lokesh
// 
// Design Name: 4 bit up counter
// Module Name: up_counter
// Description: Design for a 4 bit up counter - Sequential Circuit with posedge synchronous reset - Behavioral Modelling Style
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module up_counter(
    input clk,
    input rst,
    input load,
    input [3:0] load_value,
    output [3:0] dout
    );
    
    reg [3:0] temp;
    initial begin
        temp = 0;
    end
    
    always @ (posedge clk) begin
        if (1'b1 == rst)
            temp <= 4'b0000;
        else begin
            if (1'b1 == load)
                temp <= load_value;
            else
                temp <= temp + 1;
        end
    end
    
    assign dout = temp;  
      
endmodule
