/*
 * @Author      : myyerrol
 * @Date        : 2024-07-03 23:00:09
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-09-08 18:24:17
 * @FilePath    : /memdsl/aurora/src/common/mul/tb/mul_2nbit_booth_tb.sv
 * @Description : 2nbit booth multiplier testbench
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`timescale 1ns / 1ps

module mul_2nbit_booth_tb();

initial begin
    $dumpfile("build/mul_2nbit_booth.vcd");
    $dumpvars(0, mul_2nbit_booth_tb);
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

mul_2nbit_booth #(
    .DATA_WIDTH(DATA_WIDTH)
) u_mul_2nbit_booth(
    .i_clk(w_clk),
    .i_rst_n(w_rst_n),
    .i_num_x(w_num_x),
    .i_num_y(w_num_y),
    .o_end(),
    .o_res(),
    .o_cry()
);

endmodule
