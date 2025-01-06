`timescale 1ns / 1ps

module melay_fsm_2_process(
    input clk, rst, din,
    output reg dout
);
    parameter idle = 0;
    parameter s0 = 1;
    parameter s1 = 2; 
    
    reg [1:0] state = idle, nstate = idle;   
    
    
    
    ////////reset logic
    always@(posedge clk)
    begin
        state <= (rst == 1'b1) ? idle : nstate;
    end
    
    ////////////////////////output decoder + NSD
    always@(state, din)
    begin
        case(state)
            idle : 
            begin
                dout = 1'b0;
                nstate = s0;   
            end
            
            
            s0 : 
            begin
                if(din)
                begin
                    dout   = 1'b1;
                    nstate = s1; 
                end
                else
                begin
                    dout   = 1'b0;
                    nstate = s0;
                end
            end
            
            s1: 
            begin
                if(din)
                begin
                    dout   = 1'b0;
                    nstate = s0; 
                end
                else
                begin
                    dout   = 1'b0;
                    nstate = s1;
                end   
            end
            
            default :  
            begin
                nstate = idle;
                dout   =  1'b0;
            end
        endcase
    end
endmodule
