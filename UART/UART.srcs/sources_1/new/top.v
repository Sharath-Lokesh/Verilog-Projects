`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sharath Lokesh
// 
// Design Name: UART Module
// Module Name: uart
// Project Name: UART with Tx and RX capability
//
// Description: data frame: 1 start bit, 8 data bit and 1 stop bit = 10 bit in total
//////////////////////////////////////////////////////////////////////////////////


module uart(
    input clk,              // Clock signal
    input start,            // start of tx or rx
    input [7:0] txin,       // 8-bit data to be tx'd
    output reg tx,          // Output signal for the transmitted data
    input rx,               // Input signal for received data
    output [7:0] rxout,     // 8-bit output for received data
    output rxdone, txdone   // flags for indiacation the completion of process
    );
    // FPGA clk is usually faster than the baud rate, so we need create a slower clk/ make sure the baud rate is maintained.
    parameter clk_val = 100_000; // 100 KHz clk freq
    parameter baud_rate = 9600;
    
    // compute the number of cycles we have to wait before sending the data
    parameter wait_count = clk_val / baud_rate;
    reg bitDone = 0;
    integer count = 0;
    
    // UART TX FSM states
    parameter idle = 0, send = 1, check = 2;
    reg [1:0] state = idle;
    
    initial tx<=1;
    
    // Generate trigger for baud rate
    always @(posedge clk) begin : Trigger_baud_rate
        if (state == idle) begin
            count <= 0;
        end
        else begin
            if (count == wait_count) begin
                bitDone <= 1;
                count <= 0;
            end
            else begin
                count <= count + 1;
                bitDone <= 0;
            end
        end  
    end
    
    // Tx Logic
    // Tx variables
    reg [9:0] txData; // 10 bit data including start and stop bit
    integer bitIdx = 0;
    always@(posedge clk) begin: Tx_Logic
        case (state)
            idle: begin
                tx <= 1; // start bit is logic 0, hence tx is 1 initially
                txData <= 0;
                bitIdx <= 0;
                
                // check if the start is enabled
                if (1'b1 == start) begin
                    txData <= {1'b1, txin, 1'b0}; // (MSB) stop, data, start (LSB)
                    state <= send;
                end
                else state <= idle;
            end
            
            send: begin
                if (bitIdx < 10) begin // check if all the 10 bits are tx'd
                    tx <= txData[bitIdx];
                    if (1'b1 == bitDone) begin // each bit is tx'd at the specified baud rate
                        state <= send;
                        bitIdx <= bitIdx + 1;
                    end
                end
                else begin // after tx all the 10 bits
                    state <= idle;
                    bitIdx <= 0;
                    tx<=1;
                end 
            end
            
            default: state <= idle;
        endcase
    end
    
    assign txdone = (9 == bitIdx && 1'b1 == bitDone) ? 1'b1 : 1'b0;
    
    // RX logic
    integer rcount = 0; // sample data at the middle of the bit
    integer rIdx = 0;
    parameter ridle = 0, rwait = 1, recv = 2;
    reg [1:0] rstate = ridle;
    reg [9:0] rxdata = 0;
    
    always@(posedge clk) begin : RX_Logic
        case (rstate)
            ridle: begin
                rxdata <= 0;
                rIdx <= 0;
                rcount <= 0;
                // start bit being received
                if (1'b0 == rx) rstate <= rwait;
                else rstate <= ridle; 
            end
            
            rwait: begin
                // wait unitl the middle of the data and sample it
                if (rcount < wait_count /2) begin
                    rcount <= rcount + 1;
                    rstate <= rwait;
                end
                else begin
                    rcount <= 0;
                    rstate <= recv;
                    rxdata <= {rx, rxdata[9:1]};
                end
            end
            
            recv: begin
                if (rIdx <= 9) begin                 
                    if  (bitDone == 1'b1) begin
                        rIdx <= rIdx + 1;
                        rstate <= rwait;
                    end
                end
                else begin
                    rIdx <= 0;
                    rstate <= ridle;
                end
            end
            
            default: rstate <= ridle;
        endcase
    end
    
    
    assign rxout = rxdata[8:1];
    assign rxdone = (9 == rIdx && 1'b1 == bitDone) ? 1'b1 : 1'b0;
   
endmodule
