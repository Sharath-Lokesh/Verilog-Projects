`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sharath Lokesh
// 
// Design Name: Half Adder
// Module Name: 
// Description: Design for a Half Adder Circuit - Gate Level Modelling Style
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module half_adder(
    input a,
    input b,
    input sum,
    input carry
    );
    
    assign sum = a ^ b;
    assign carry = a & b;
endmodule
