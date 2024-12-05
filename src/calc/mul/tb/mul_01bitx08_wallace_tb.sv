/*
 * @Author      : myyerrol
 * @Date        : 2024-07-07 22:00:52
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-09-08 18:24:10
 * @FilePath    : /memdsl/aurora/src/common/mul/tb/mul_01bitx08_wallace_tb.sv
 * @Description : 01bit wallace tree for adding 8 numbers testbench
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`timescale 1ns / 1ps

`include "add_01bit_full.sv"

module mul_01bitx08_wallace_tb();

initial begin
    $dumpfile("build/mul_01bitx08_wallace.vcd");
    $dumpvars(0, mul_01bitx08_wallace_tb);
end

logic [7 : 0] w_num;
logic [5 : 0] w_cry;

initial begin
    w_num = 8'b0000_0010;
    w_cry = 6'b000000;
    #10;
    w_num = 8'b0000_0011;
    w_cry = 6'b000000;
    #10;
    w_num = 8'b0000_0110;
    w_cry = 6'b000000;
    #10;
    w_num = 8'b0000_1100;
    w_cry = 6'b000000;
    #10;
    w_num = 8'b0001_1000;
    w_cry = 6'b000000;
    #10;
    w_num = 8'b0011_0000;
    w_cry = 6'b000000;
    #10;
    w_num = 8'b0110_0000;
    w_cry = 6'b000000;
    #10;
    w_num = 8'b1100_0000;
    w_cry = 6'b000000;
    #10;
    $finish;
end

mul_01bitx08_wallace u_mul_01bitx08_wallace(
    .i_num(w_num),
    .i_cry_06bit(w_cry),
    .o_cry_06bit(),
    .o_res(),
    .o_cry()
);

endmodule
