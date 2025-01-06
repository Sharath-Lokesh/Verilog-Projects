`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sharath Lokesh
// 
// Design Name: 3 process Melay FSM
// Module Name: mealy_fsm_3_process
// Description: Design for a Melay FSM - 3 process methodology
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////

module mealy_fsm_3_process(
    input clk, rst, din,
    output reg dout
);
    // in system verilog we can use enums
    parameter idle = 0;
    parameter s0 = 1;
    parameter s1 = 2; 
     
    reg [1:0] state = idle, nstate = idle;   
     
    /////reset logic  -----Sequential process  
       always@(posedge clk)
       begin
         if(rst == 1'b1)
           state <= idle;
         else
           state <= nstate;
       end 
        
    ///////////output decoder
     
    always@(state, din)   
    begin
          case(state)
              idle : dout = 1'b0; 
              s0   : dout = (1'b1 == din) ? 1'b1 :1'b0;
              s1   : dout = 1'b0;
              default: dout = 1'b0;
          endcase
    end 
    //////////////////Next State decoder
     
    always@(state,din)
    begin
        case(state)
            idle : nstate = (1'b1 == rst) ? idle : s0;
            s0: nstate = (din == 1'b1) ? s1 : s0;
            s1 : nstate = (din == 1'b1) ? s0 : s1;
            default : nstate = idle; 
        endcase
    end    
endmodule