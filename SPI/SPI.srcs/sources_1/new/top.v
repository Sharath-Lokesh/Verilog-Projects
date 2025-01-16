`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2024 06:25:57 AM
// Design Name: SPI protocol
// Module Name: spi
// Description: Simple SPI protocol for MOSI and MISO with 12 bit of data transfer
//////////////////////////////////////////////////////////////////////////////////


module spi(
    input clk,              // system clk
    input [11:0] din,       // 12 bit data
    input start_tx,            // start mosi tx
    input start_rx,            // start miso rx
    
    output reg cs,          // chip select active low
    output reg mosi,        // mosi channel
    input miso,        // miso channel
    output sclk,             // sclk for slave
    output [11:0] dout,     // output register to see the miso data
    output reg tx_done, rx_done
    );
    
    // Generate sclk
    parameter sys_clk = 10_000_000; // assuming system clcok is 10MHz
    parameter baudrate = 1_000_000; // 1 Mbps
    parameter clk_div = sys_clk / baudrate;
    integer count = 0, r_count = 0;
    reg _sclk = 0;
    
    initial begin
        cs <= 1;
        mosi <= 0;
        tx_done <= 0;
        rx_done <= 0;
    end
    
    always@(posedge clk) begin : Generate_SCLK
        if (count < (clk_div / 2)) // toggle the clk at half period 
            count <= count + 1;
        else begin
            count <= 0;
            _sclk <= ~_sclk;
        end
    end
    
    assign sclk = _sclk;
    
    //MOSI: TX logic
    parameter t_idle = 0, t_start = 1, t_send = 2, t_end = 3;
    reg [1:0] t_state = t_idle;
    reg [11:0] t_temp = 0;
    integer t_bitcount = 0;
    
    always @(posedge _sclk) begin : MOSI
        case (t_state)
            t_idle: begin
                cs <= (start_tx || start_rx) ? 0 : 1;
                mosi <= 0;
                tx_done <= 0;
                
                if (start_tx) t_state <= t_start;
                else t_state <= t_idle;
            end
            
            t_start: begin
                cs <= 0;
                t_temp <= din;
                t_state <= t_send;
            end
            
            t_send: begin
                if (t_bitcount <= 11) begin
                    t_bitcount <= t_bitcount + 1;
                    mosi <= t_temp[t_bitcount];
                    t_state <= t_send;
                end
                else begin
                    t_bitcount <= 0;
                    mosi <= 0; // stop bit
                    t_state <= t_end;
                end
            end
            
            t_end: begin
                cs <= (start_tx || start_rx) ? 0 : 1;
                tx_done <= 1;
                t_state <= t_idle;
            end
            
            default: t_state <= t_idle;
        endcase
    end
    
    //MISO: RX logic
    parameter r_idle = 0, r_start = 1, r_recv = 2, r_end = 3;
    reg [1:0] r_state = r_idle;
    reg [11:0] r_temp = 0;
    integer r_bitcount = 0;
    
    always@(posedge _sclk) begin: MISO
        case (r_state)
            r_idle: begin
                cs <= (start_tx || start_rx) ? 0 : 1;
                r_temp <= 0;
                rx_done <= 0;
                
                if (start_rx) r_state <= r_start;
                else r_state <= r_idle;
            end
            
            r_start: begin
                cs <= 0;
                if (miso == 0) r_state <= r_recv; //capture the start bit
                else r_state <= r_start;
            end
            
            r_recv: begin
                    
                    if (r_bitcount < 12) begin // 12 data bit
                        r_temp <= {miso, r_temp[11:1]};
                        r_bitcount <= r_bitcount + 1;
                        r_state <= r_recv;
                    end
                    else begin
                        r_temp <= {miso, r_temp[11:1]}; // capture the last bit
                        r_bitcount <= 0;                        
                        r_state <= r_end;
                    end                
            end
            
            r_end: begin
                r_temp <= 0;
                cs <= (start_tx || start_rx) ? 0 : 1;
                rx_done <= 1;
                r_state <= r_idle;
            end
            
            default: r_state <= r_idle;
            
        endcase
    end
    
    assign dout = r_temp;
     
endmodule
