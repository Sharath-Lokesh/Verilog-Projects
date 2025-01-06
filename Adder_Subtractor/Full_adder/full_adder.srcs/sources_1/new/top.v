`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sharath Lokesh
// 
// Design Name: Full Adder
// Module Name: full_adder
// Description: Design for a Full Adder Circuit - Gate Level Modelling Style
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module full_adder(
    input a,
    input b,
    input c,
    input sum,
    input carry
    );
    
    wire t1, t2, t3;
    
    assign t1 = a ^ b;
    assign t2 = t1 & c;
    assign t3 = a & b;
    
    assign sum = t1 ^ c;
    assign carry = t2 | t3;
    
endmodule
