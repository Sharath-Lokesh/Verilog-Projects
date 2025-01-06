`timescale 1ns / 1ps
 
module moore_fsm_2_process(
    input clk, rst, din,
    output reg dout
    );
    parameter idle = 0;
    parameter s0 = 1;
    parameter s1 = 2; 
     
    reg [1:0] state = idle, nstate = idle;   
        
    /////three process methodology 
     
    /////reset logic  -----Sequential process  
    always@(posedge clk)
    begin
     if(rst == 1'b1)
       state <= idle;
     else
       state <= nstate;
    end 
        
    ///////////output decoder + next state decoder
    always@(state,din)
    begin
        case(state)
            idle: begin
              dout = 1'b0; 
              nstate = s0;   
            end
             
            s0 : begin
              dout = 1'b0;
            if(din == 1'b1)
               nstate = s1;
            else
               nstate = s0;
            end
             
            s1: begin
              dout = 1'b1;
              if(din == 1'b1)
               nstate = s0;
             else
               nstate = s1;
            end 
            default: begin
                dout = 1'b0;
                state = idle;
            end   
        endcase
    end
       
endmodule