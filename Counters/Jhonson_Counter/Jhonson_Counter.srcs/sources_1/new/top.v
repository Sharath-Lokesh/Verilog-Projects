`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sharath Lokesh
// 
// Design Name: 4 bit Jhonson Counter
// Module Name: Johnson_Counter
// Description: Design for a D4 bit Jhonson Counter - Behavioral Modelling Style
// 
// Dependencies: dff module
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////

module Johnson_Counter(
    input clk,
    input rst,
    output [3:0] dout
    );
    reg [3:0] temp = 0;
    
    always @ (posedge clk) begin
        if (1'b1 == rst)
           temp <= 4'b0000;
        else begin
            temp <= {~temp[0], temp[3], temp[2], temp[1]};
        end 
    end
    
    assign dout = temp;
endmodule
