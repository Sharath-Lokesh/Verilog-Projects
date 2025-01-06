`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sharath Lokesh
// 
// Create Date: 12/29/2024 01:03:37 PM
// Design Name: Overlapping Sequence Detector
// Module Name: overlapping_sequence_detector
// Description:  Overlapping Sequence Detector to recognize the pattern 111
//
//////////////////////////////////////////////////////////////////////////////////


module overlapping_sequence_detector(
    input clk, rst, din,
    output reg dout
    );
    
    parameter idle = 0;
    parameter s0 = 1;
    parameter s1 = 2;
    parameter s2 = 3; 
    
    reg [1:0] state = idle;   
    // Mealy FSm: 1 process methodology
    always@(posedge clk)
    begin
        if(rst)
        begin
            dout <= 1'b0;
            state <= idle;
        end
        else begin   
            case(state)
            idle : begin
                dout <= 1'b0;
                state <= s0;
            end
            
            s0: begin
                dout  <= 1'b0;
                state <= (din == 1'b1) ? s1:  s0;
            end
            
            s1: begin
                dout  <= 1'b0;
                state <= (din == 1'b1) ? s2:  s0;
            end
            
            s2: begin
                if(din == 1'b1)
                begin
                    state <= s2;
                    dout  <= 1'b1;
                end
                else
                begin
                    state <= s0;
                    dout  <= 1'b0; 
                end
            end
            
            default : 
            begin
                state <= idle;
                dout  <= 1'b0; 
            end
            endcase
        end 
    end
endmodule
