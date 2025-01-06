`timescale 1ns/ 1ps

module mealy_fsm_1_process(
    input clk, rst, din,
    output reg dout
);
    parameter idle = 0;
    parameter s0 = 1;
    parameter s1 = 2; 
    
    reg [1:0] state = idle; 
    
    always@(posedge clk)
    begin
        if(rst == 1'b1)
        begin
            state <= idle;
            dout  <= 1'b0;
        end
        else 
        begin
            case(state)
                idle: begin
                    dout <= 1'b0;
                    state <= s0;
                end
                
                s0: begin 
                    if(din)
                    begin
                        dout   <= 1'b1;
                        state  <= s1; 
                    end
                    else
                    begin
                        dout  <= 1'b0;
                        state <= s0;
                    end 
                end
                
                s1: 
                begin
                    dout  <= 1'b0;
                    state <= (1'b1 == din) ? s0 : s1; 
                end
                
                default: begin
                    state  <= idle;
                    dout   <=  1'b0;
                end
            endcase
        end           
    end

endmodule
