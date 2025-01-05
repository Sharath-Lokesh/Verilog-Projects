`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sharath Lokesh
// 
// Design Name: 4:1 MUX
// Module Name: MUX_4_1
// Description: Design for a 4:1 MUX Combinatianal Circuit - Behavioral Modelling Style
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module MUX_4_1(
    input a,
    input b,
    input c,
    input d,
    input [1:0] s,
    output y
    );
    
    reg temp;
    
    always @(*) begin
        if (s == 2'b00)
            temp = a;
        else if  (s == 2'b01)
            temp = b;
        else if (s == 2'b10)
            temp = c;
        else
            temp = d;
    end
    
    assign y = temp;
    
endmodule
