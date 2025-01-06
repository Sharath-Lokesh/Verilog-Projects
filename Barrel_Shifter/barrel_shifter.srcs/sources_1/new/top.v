`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sharath Lokesh
// 
// Design Name: 4:1 MUX IP Block
// Module Name: 
// Description: Design for a 4:1 MUX Combinatianal Circuit - IP Block
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_4to1(
    input a,
    input b,
    input c,
    input d,
    input [1:0] s,
    output y
    );
    
    reg temp;
    
    always@(*) begin
        case(s)
            2'b00: temp <= a;
            2'b01: temp <= b;
            2'b10: temp <= c;
            2'b11: temp <= d;
            default: temp <= a;
        endcase
    end
    assign y = temp;
endmodule
