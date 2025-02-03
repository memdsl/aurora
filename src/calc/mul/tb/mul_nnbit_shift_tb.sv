/*
 * @Author      : myyerrol
 * @Date        : 2024-07-02 19:01:58
 * @LastEditors : myyerrol
 * @LastEditTime: 2025-02-03 14:25:10
 * @Description : nnbit shfit multiplier testbench
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`timescale 1ns / 1ps

module mul_nnbit_shift_tb();

initial begin
    $dumpfile("build/mul_nnbit_shift_tb.vcd");
    $dumpvars(0, mul_nnbit_shift_tb);
end

parameter CYCLE      = 10;
parameter DATA_WIDTH = 4;

logic                      r_clk;
logic                      r_rst_n;
logic [DATA_WIDTH - 1 : 0] r_num_x;
logic [DATA_WIDTH - 1 : 0] r_num_y;

always #(CYCLE / 2) r_clk = ~r_clk;

initial begin
    r_clk   = 1'b0;
    r_rst_n = 1'b0;
    r_num_x = 4'b1010;
    r_num_y = 4'b1001;
    #(CYCLE * 1);
    r_rst_n = 1'b1;
    #(CYCLE * 10);
    r_rst_n = 1'b0;
    r_num_x = 4'b1010;
    r_num_y = 4'b0101;
    #(CYCLE * 1);
    r_rst_n = 1'b1;
    #(CYCLE * 10);
    $finish;
end

mul_nnbit_shift #(
    .DATA_WIDTH(DATA_WIDTH)
) u_mul_nnbit_shift(
    .i_clk  (r_clk),
    .i_rst_n(r_rst_n),
    .i_num_x(r_num_x),
    .i_num_y(r_num_y),
    .o_end  (),
    .o_res  ()
);

endmodule
