/*
 * @Author      : myyerrol
 * @Date        : 2024-07-07 22:00:52
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-12-19 14:13:53
 * @Description : 01bit wallace tree for adding 8 numbers testbench
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`timescale 1ns / 1ps

module mul_01bitx08_wallace_tb();

initial begin
    $dumpfile("build/mul_01bitx08_wallace_tb.vcd");
    $dumpvars(0, mul_01bitx08_wallace_tb);
end

logic [7 : 0] r_num;
logic [5 : 0] r_cry;

initial begin
    r_num = 8'b0000_0010;
    r_cry = 6'b000000;
    #10;
    r_num = 8'b0000_0011;
    r_cry = 6'b000000;
    #10;
    r_num = 8'b0000_0110;
    r_cry = 6'b000000;
    #10;
    r_num = 8'b0000_1100;
    r_cry = 6'b000000;
    #10;
    r_num = 8'b0001_1000;
    r_cry = 6'b000000;
    #10;
    r_num = 8'b0011_0000;
    r_cry = 6'b000000;
    #10;
    r_num = 8'b0110_0000;
    r_cry = 6'b000000;
    #10;
    r_num = 8'b1100_0000;
    r_cry = 6'b000000;
    #10;
    $finish;
end

mul_01bitx08_wallace u_mul_01bitx08_wallace(
    .i_num      (r_num),
    .i_cry_06bit(r_cry),
    .o_cry_06bit(),
    .o_res      (),
    .o_cry      ()
);

endmodule
