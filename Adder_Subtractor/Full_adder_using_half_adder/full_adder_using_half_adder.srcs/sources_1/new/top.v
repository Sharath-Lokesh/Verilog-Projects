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
