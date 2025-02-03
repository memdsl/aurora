/*
 * @Author      : myyerrol
 * @Date        : 2024-07-16 20:05:41
 * @LastEditors : myyerrol
 * @LastEditTime: 2025-02-03 14:24:51
 * @Description : 01bit absolute value iterative divider testbench
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`timescale 1ns / 1ps

module div_nnbit_s01_abs_itera_tb();

initial begin
    $dumpfile("build/div_nnbit_s01_abs_itera_tb.vcd");
    $dumpvars(0, div_nnbit_s01_abs_itera_tb);
end

parameter CYCLE      = 10;
parameter DATA_WIDTH = 8;

logic                      r_clk;
logic                      r_rst_n;
logic                      r_valid_i;
logic [DATA_WIDTH - 1 : 0] r_num_x;
logic [DATA_WIDTH - 1 : 0] r_num_y;
logic                      r_valid_o;

always #(CYCLE / 2) r_clk = ~r_clk;

initial begin
    r_clk   = 1'b0;
    r_rst_n = 1'b0;
    r_num_x = 8'b10010101;
    r_num_y = 8'b00011101;
    #(CYCLE * 1)
    r_rst_n = 1'b1;
    #(CYCLE * 50);
    $finish;
end

div_nnbit_s01_abs_itera #(
    .DATA_WIDTH(8)
) u_div_nnbit_s01_abs_itera(
    .i_clk   (r_clk),
    .i_rst_n (r_rst_n),
    .i_valid (r_valid_i),
    .i_signed(1'b1),
    .i_num_x (r_num_x),
    .i_num_y (r_num_y),
    .o_res   (),
    .o_rem   (),
    .o_valid (r_valid_o)
);

assign r_valid_i = ~r_valid_o;

endmodule
