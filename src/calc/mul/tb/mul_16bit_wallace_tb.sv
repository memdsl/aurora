/*
 * @Author      : myyerrol
 * @Date        : 2024-07-05 08:45:17
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-12-19 14:24:15
 * @Description : 16bit wallace tree multiplier testbench
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`timescale 1ns / 1ps

module mul_16bit_wallace_tb();

initial begin
    $dumpfile("build/mul_16bit_wallace_tb.vcd");
    $dumpvars(0, mul_16bit_wallace_tb);
end

parameter CYCLE      = 10;
parameter DATA_WIDTH = 16;

logic                      r_clk;
logic                      r_rst_n;
logic [DATA_WIDTH - 1 : 0] r_num_x;
logic [DATA_WIDTH - 1 : 0] r_num_y;

always #(CYCLE / 2) r_clk = ~r_clk;

initial begin
    r_clk   = 1'b0;
    r_rst_n = 1'b0;
    r_num_x = 16'b1111_1111_1111_1010;
    r_num_y = 16'b1111_1111_1111_1001;
    #(CYCLE * 1);
    r_rst_n = 1'b1;
    #(CYCLE * 10);
    r_rst_n = 1'b0;
    r_num_x = 16'b1111_1111_1111_1010;
    r_num_y = 16'b0000_0000_0000_0101;
    #(CYCLE * 1);
    r_rst_n = 1'b1;
    #(CYCLE * 10);
    $finish;
end

mul_16bit_wallace u_mul_16bit_wallace(
    .i_clk  (r_clk),
    .i_rst_n(r_rst_n),
    .i_num_x(r_num_x),
    .i_num_y(r_num_y),
    .o_end  (),
    .o_res  (),
    .o_cry  ()
);

endmodule