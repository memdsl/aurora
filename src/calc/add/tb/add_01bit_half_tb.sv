/*
 * @Author      : myyerrol
 * @Date        : 2024-06-28 14:52:17
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-09-08 18:22:39
 * @FilePath    : /memdsl/aurora/src/common/adder/tb/add_01bit_half_tb.sv
 * @Description : 01bit half adder testbench
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`timescale 1ns / 1ps

module add_01bit_half_tb();

initial begin
    $dumpfile("build/add_01bit_half.vcd");
    $dumpvars(0, add_01bit_half_tb);
end

logic w_num_a;
logic w_num_b;

initial begin
    w_num_a = 0;
    w_num_b = 0;
    #10 w_num_a = 0; w_num_b = 0;
    #10 w_num_a = 0; w_num_b = 1;
    #10 w_num_a = 1; w_num_b = 0;
    #10 w_num_a = 1; w_num_b = 1;
    #10 $finish;
end

add_01bit_half u_add_01bit_half(
    .i_num_a(w_num_a),
    .i_num_b(w_num_b),
    .o_res(),
    .o_cry()
);

endmodule
