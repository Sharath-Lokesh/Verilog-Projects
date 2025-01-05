module down_counter
(
    input clk, rst,///active high
    input ld,
    input [3:0] ldvalue,
    output [3:0] dout 
);
 
  reg [3:0] temp = 0;
 
    //always@(posedge clk) /////////synchronus reset
    //or
    always@(posedge clk, posedge rst) /////////////asynchronus reset
    begin
     if(rst == 1'b1)
       begin
       temp <= 4'b0000;
       end
     else 
         begin
           if(ld == 1'b1)
             temp <= ldvalue;
           else
             temp <= temp - 1;
         end
    end
     
    assign dout = temp;
     
endmodule