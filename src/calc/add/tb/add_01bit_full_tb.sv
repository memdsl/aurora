/*
 * @Author      : myyerrol
 * @Date        : 2024-06-28 14:52:06
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-09-08 18:22:29
 * @FilePath    : /memdsl/aurora/src/common/adder/tb/add_01bit_full_tb.sv
 * @Description : 01bit full adder testbench
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`timescale 1ns / 1ps

module add_01bit_full_tb();

initial begin
    $dumpfile("build/add_01bit_full.vcd");
    $dumpvars(0, add_01bit_full_tb);
end

logic w_num_a;
logic w_num_b;
logic w_cry;

initial begin
        w_num_a = 0; w_num_b = 0; w_cry = 0;
    #10 w_num_a = 0; w_num_b = 1; w_cry = 0;
    #10 w_num_a = 1; w_num_b = 0; w_cry = 0;
    #10 w_num_a = 1; w_num_b = 1; w_cry = 0;
    #10 w_num_a = 0; w_num_b = 0; w_cry = 1;
    #10 w_num_a = 0; w_num_b = 1; w_cry = 1;
    #10 w_num_a = 1; w_num_b = 0; w_cry = 1;
    #10 w_num_a = 1; w_num_b = 1; w_cry = 1;
    #10 $finish;
end

add_01bit_full u_add_01bit_full(
    .i_num_a(w_num_a),
    .i_num_b(w_num_b),
    .i_cry(w_cry),
    .o_res(),
    .o_cry()
);

endmodule
