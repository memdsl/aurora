/*
 * @Author      : myyerrol
 * @Date        : 2024-06-28 14:52:06
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-06-29 10:57:14
 * @FilePath    : /memdsl-cpu/meteor/ip/src/sv/common/adder/sim/adder_1bit_full_tb.sv
 * @Description : 1bit full adder testbench
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`timescale 1ns / 1ps

module adder_1bit_full_tb();

initial begin
    $dumpfile("build/adder_1bit_full.vcd");
    $dumpvars();
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

adder_1bit_full adder_1bit_full_inst(
    .i_num_a(w_num_a),
    .i_num_b(w_num_b),
    .i_cry(w_cry),
    .o_res(),
    .o_cry()
);

endmodule
