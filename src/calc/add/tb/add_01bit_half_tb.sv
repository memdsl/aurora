/*
 * @Author      : myyerrol
 * @Date        : 2024-06-28 14:52:17
 * @LastEditors : myyerrol
 * @LastEditTime: 2025-02-03 14:24:29
 * @Description : 01bit half adder testbench
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`timescale 1ns / 1ps

module add_01bit_half_tb();

initial begin
    $dumpfile("build/add_01bit_half_tb.vcd");
    $dumpvars(0, add_01bit_half_tb);
end

logic r_num_a;
logic r_num_b;

initial begin
    r_num_a = 0;
    r_num_b = 0;
    #10 r_num_a = 0; r_num_b = 0;
    #10 r_num_a = 0; r_num_b = 1;
    #10 r_num_a = 1; r_num_b = 0;
    #10 r_num_a = 1; r_num_b = 1;
    #10 $finish;
end

add_01bit_half u_add_01bit_half(
    .i_num_a(r_num_a),
    .i_num_b(r_num_b),
    .o_res  (),
    .o_cry  ()
);

endmodule
