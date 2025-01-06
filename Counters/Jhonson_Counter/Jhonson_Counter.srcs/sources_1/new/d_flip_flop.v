`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sharath Lokesh
// 
// Design Name: D Flip FLop
// Module Name: top
// Description: Design for a D Flip Flop - Behavioral Modelling Style
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module dff(
    input din,
    input clk,
    output dout
    );
    reg q = 0;
    
    always@(posedge clk) begin
        q <= din;
    end
    
    assign dout = q;
    
endmodule
