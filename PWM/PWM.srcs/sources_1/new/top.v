`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sharath Lokesh
// 
// Design Name: Pulse Width Modulation 
// Module Name: pwm
// Description: PWM to demonstrate feeding effect
// 
//////////////////////////////////////////////////////////////////////////////////


module pwm(
    input clk,
    input rstn, // active low synchronous reset
    output reg dout
    );
    
    parameter period = 100;
    integer count = 0;
    integer ton = 0, reverse = 0;
    
    always @ (posedge clk) begin
        if (0 == rstn) begin
            count <= 0;
            ton <= 0;
        end
        else begin
            if (count <= ton) begin
                count <= count + 1;
                dout <= 1;
            end
            else if (count < period) begin
                count <= count + 1;
                dout <= 0;
            end
            else begin
                count <= 0;
                if (ton < period && 0 == reverse) ton <= ton + 5;
                else if (ton > 0 && 1 == reverse) ton <= ton - 5;
                else if (ton == period) reverse <= 1;
                else begin 
                    ton <= 0;
                    reverse <= 0;
                end
            end
            
        end
    end
endmodule
