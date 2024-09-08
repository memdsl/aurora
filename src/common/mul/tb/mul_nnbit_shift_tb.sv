/*
 * @Author      : myyerrol
 * @Date        : 2024-07-02 19:01:58
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-09-08 18:24:31
 * @FilePath    : /memdsl/aurora/src/common/mul/tb/mul_nnbit_shift_tb.sv
 * @Description : nnbit shfit multiplier testbench
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`timescale 1ns / 1ps

module mul_nnbit_shift_tb();

initial begin
    $dumpfile("build/mul_nnbit_shift.vcd");
    $dumpvars(0, mul_nnbit_shift_tb);
end

parameter CYCLE      = 10;
parameter DATA_WIDTH = 4;

logic                      w_clk;
logic                      w_rst_n;
logic [DATA_WIDTH - 1 : 0] w_num_x;
logic [DATA_WIDTH - 1 : 0] w_num_y;

always #(CYCLE / 2) w_clk = ~w_clk;

initial begin
    w_clk   = 1'b0;
    w_rst_n = 1'b0;
    w_num_x = 4'b1010;
    w_num_y = 4'b1001;
    #(CYCLE * 1);
    w_rst_n = 1'b1;
    #(CYCLE * 10);
    w_rst_n = 1'b0;
    w_num_x = 4'b1010;
    w_num_y = 4'b0101;
    #(CYCLE * 1);
    w_rst_n = 1'b1;
    #(CYCLE * 10);
    $finish;
end

mul_nnbit_shift #(
    .DATA_WIDTH(DATA_WIDTH)
) u_mul_nnbit_shift(
    .i_clk(w_clk),
    .i_rst_n(w_rst_n),
    .i_num_x(w_num_x),
    .i_num_y(w_num_y),
    .o_end(),
    .o_res()
);

endmodule
