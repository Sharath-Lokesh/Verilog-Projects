`timescale 1ns / 1ps

module non_overlapping_sequence_detector(
    input clk, rst, din,
    output reg dout
);

    parameter idle = 0;
    parameter s0 = 1;
    parameter s1 = 2;
    parameter s2 = 3; 
    
    reg [1:0] state = idle;   
    
    
    always@(posedge clk)
    begin
        if(rst)
        begin
            state <= idle;
            dout <= 1'b0;
        end
        else begin
            case(state)
                idle : begin
                    dout <= 1'b0;
                    state <= (rst == 1'b1) ? idle : s0;
                end
                s0: begin
                    dout  <= 1'b0;
                    state <= (din == 1'b1) ? s1 : s0;
                end
            
                s1: begin
                    dout  <= 1'b0;
                    state <= (din == 1'b1) ? s2 : s0;
                end
                            
                s2: begin
                    state <= s0;
                    dout <= (din == 1'b1) ? 1'b1 : 1'b0; 
                end
           
            default : begin
                state <= idle;
                dout  <= 1'b0; 
            end
            endcase
        end
    end
endmodule
