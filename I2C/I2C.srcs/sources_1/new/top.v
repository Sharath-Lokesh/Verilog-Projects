`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////// 
// Engineer: Sharath Lokesh
// Design Name: I2C  
// Module Name: i2c
// Project Name: I2C communication protocol
// Description: 
// 
//////////////////////////////////////////////////////////////////////////////////


module i2c(
    input clk,
    input rstn,
    input ack,
    input enable, // begin the i2c operation
    input rw,
    
    input [7:0] wdata,
    input [6:0] addr, // 7bit addr and 1 bit mode
    output reg [7:0] rdata,
    
    output reg done,
    
    output scl,
    inout sda
    );
    
    reg sda_en = 1;
    
    reg scl_temp = 0;
    reg sda_temp = 0;
    reg [7:0] rdata_temp;
    reg [7:0] addr_temp;
    
    //FSM states
    parameter s_idle = 0, s_start =1, s_addr = 2, s_ack = 3, s_write_data = 4,
              s_wack = 5, s_read_data = 6, s_stop = 7;
   reg [2:0] state = s_idle;
    
    reg sclk = 0;
    parameter clk_div = 1_000_000 / 400_000;
    integer count = 0;
    
    
    always @(posedge clk) begin : generate_slow_clk
        if (count < clk_div / 2) count <= count + 1;
        else begin
            count <= 0;
            sclk <= ~sclk;
        end
    end
    
    integer i = 7, j = 0;
    always @ (posedge sclk, rstn) begin : i2c_fsm
        if (0 == rstn) begin
            scl_temp <= 0;
            sda_temp <= 0;
            done <= 0;
        end
        else begin
            case(state)
                s_idle: begin
                    scl_temp <= 1;
                    sda_temp <= 1;
                    done <= 0;
                    sda_en <= 1;
                    i <= 7;
                    j <= 0;
                    addr_temp <= 0;
                    
                    if (1 == enable) state <= s_start;
                    else state <= s_idle;
                end
                
                s_start: begin
                    sda_temp  <= 1'b0;
                    scl_temp  <= 1'b1;
                    addr_temp <= {addr,rw};
                    
                    state <= s_addr;
                end
                
                s_addr: begin
                    if(i > 0) begin
                        sda_temp <= addr_temp[i]; // send addr MSB to LSB (7 bit)
                        i <= i-1;
                        state <= s_addr;
                    end
                    else begin
                        sda_temp <= addr_temp[0]; // send rw (1 bit)
                        i <= 7;
                        state <= s_ack;
                    end                    
                end
                
                s_ack: begin
                    if (0 == ack) begin // active low ack
                        if(1 == addr_temp[0]) begin // read mode
                            state <= s_read_data;
                            sda_en <= 1'b0;
                        end 
                        else state <= s_write_data;
                    end
                    else state <= s_ack; // wait for ack
                end
                
                // write operation
                s_write_data: begin
                    if (j <= 7) begin
                        j <= j+1;
                        sda_temp <= wdata[j];
                        state <= s_write_data;
                    end
                    else begin
                        j <= 0;
                        state <= s_wack;
                    end
                end
                
                s_wack: begin
                    if(ack == 1'b0) begin
                       state <= s_stop;
                       sda_temp <= 1'b0;
                       scl_temp <= 1'b1;
                     end
                     else begin
                       state <= s_wack;
                     end
                end
                
                // read
                s_read_data: begin
                    if (j <= 7) begin
                        j <= j+1;
                        rdata[j]  <= sda;
                        state <= s_read_data;
                    end
                    else begin
                        j <= 0;
                        state <= s_stop;
                        scl_temp <= 1;
                        sda_temp <= 0;
                    end
                end
                
                s_stop: begin
                    sda_temp  <=  1'b1;
                    state <=  s_idle;
                    done  <=  1'b1;
                end
                
                default: state <= s_idle;
                
            endcase
        end
    end
    
    assign scl = (( state == s_start) || ( state == s_stop)) ? scl_temp : sclk;
    assign sda = (sda_en == 1'b1) ? sda_temp : 1'bz;
    
endmodule
