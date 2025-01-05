`timescale 1ns / 1ps

// 2:1 Mux with complemented output
module MUX_2_1 (
    input select,
    input a,
    input b,
    output y,
    output y_bar
);

    assign y = (select) ? a : b; 
    assign y_bar = ~y; 

endmodule

// 4:1 Mux with True and Complemented output using 2:1 Muxes
module MUX_4_1 (
    input [1:0] select,
    input a,
    input b,
    input c,
    input d,
    output y,
    output y_bar
);

    wire w1, w2, w1_bar, w2_bar; 

    MUX_2_1 m1 (
        .select(select[0]),
        .a(a),
        .b(b),
        .y(w1),
        .y_bar(w1_bar)
    );

    MUX_2_1 m2 (
        .select(select[0]),
        .a(c),
        .b(d),
        .y(w2),
        .y_bar(w2_bar)
    );

    MUX_2_1 m3 (
        .select(select[1]),
        .a(w1),
        .b(w2),
        .y(y),
        .y_bar(y_bar)
    );

endmodule
