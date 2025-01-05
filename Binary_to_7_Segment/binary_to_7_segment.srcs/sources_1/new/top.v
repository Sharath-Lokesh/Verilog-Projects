`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sharath Lokesh
// 
// Design Name: Binary to 7 segment
// Module Name: binary_2_seven_segment
// Description: Design for a common anode 7 segment display - Behavioral Modelling Style
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module binary_2_seven_segment(
    input [3:0] bin,
    output [6:0] sout
    );
    
    reg [7:0] temp = 0;
    
    always@(*) begin
        case(bin)
            4'b0000: temp = 8'hFC; //0
            4'b0001: temp = 8'h60; //1
            4'b0010: temp = 8'hDA; //2
            4'b0011: temp = 8'hF2; //3
            4'b0100: temp = 8'h66; //4
            4'b0101: temp = 8'hB6; //5
            4'b0110: temp = 8'hBE; //6
            4'b0111: temp = 8'hE0; //7
            4'b1000: temp = 8'hFE; //8
            4'b1001: temp = 8'hF6; //9
            default : temp = 8'h00;
        endcase
    end
    
    assign sout = temp[7:1];
endmodule
