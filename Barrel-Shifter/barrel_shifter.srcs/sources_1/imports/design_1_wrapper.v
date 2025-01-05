//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
//Date        : Thu Dec 26 18:06:10 2024
//Host        : MSI running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (dout,
    s,
    w);
  output [3:0]dout;
  input [1:0]s;
  input [3:0]w;

  wire [3:0]dout;
  wire [1:0]s;
  wire [3:0]w;

  design_1 design_1_i
       (.dout(dout),
        .s(s),
        .w(w));
endmodule
