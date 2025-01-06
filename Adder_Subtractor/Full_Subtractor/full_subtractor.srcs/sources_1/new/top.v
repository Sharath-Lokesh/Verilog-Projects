`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Sharath Lokesh
// 
// Design Name: Full Sbutractor
// Module Name: full_subtractor
// Description: Design for a Full Sbutractor Circuit - Gate Level Modelling Style
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module full_subtractor (
    input a, 
    input b, 
    input bin, 
    output diff, 
    output bout 
);

    wire not_b, not_bin, a_xor_b, a_xor_b_xor_bin, a_and_b, a_and_bin, b_and_bin;

    not inv1 (not_b, b);
    not inv2 (not_bin, bin);

    xor x1 (a_xor_b, a, not_b);
    xor x2 (a_xor_b_xor_bin, a_xor_b, not_bin);

    and a1 (a_and_b, a, not_b);
    and a2 (a_and_bin, a, not_bin);
    and a3 (b_and_bin, not_b, bin);

    or o1 (diff, a_xor_b_xor_bin); 
    or o2 (bout, a_and_b, b_and_bin, a_and_bin); 

endmodule