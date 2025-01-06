`timescale 1ns / 1ps

module half_adder(
    input a,
    input b,
    output sum,
    output carry);
    
    assign sum = a ^ b;
    assign carry = a & b; 
endmodule


module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
    );
    
    wire t1, t2, t3;
    
    half_adder h1 (a, b, t1, t2);
    half_adder h2 (t1, cin, sum, t3);
    
    assign cout = t2 | t3;
endmodule

module ripple_carry_adder(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] sum,
    output cout
    );
    wire c0, c1, c2;
    full_adder fa1 (a[0], b[0], cin, sum[0], c0);
    full_adder fa2 (a[1], b[1], c0, sum[1], c1);
    full_adder fa3 (a[2], b[2], c1, sum[2], c2);
    full_adder fa4 (a[3], b[3], c2, sum[3], cout);
endmodule
