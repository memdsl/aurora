/*
 * @Author      : myyerrol
 * @Date        : 2024-07-05 08:45:17
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-07-07 17:01:03
 * @FilePath    : /memdsl/aurora/src/sv/common/mul/tb/mul_16bit_wallace_tb.sv
 * @Description : 16bit wallace tree multiplier testbench
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`timescale 1ns / 1ps

module mul_16bit_wallace_tb();

initial begin
    $dumpfile("build/mul_16bit_wallace.vcd");
    $dumpvars(0, mul_16bit_wallace_tb);
end

parameter CYCLE      = 10;
parameter DATA_WIDTH = 16;

logic                      w_clk;
logic                      w_rst_n;
logic [DATA_WIDTH - 1 : 0] w_num_a;
logic [DATA_WIDTH - 1 : 0] w_num_b;

always #(CYCLE / 2) w_clk = ~w_clk;

initial begin
    w_clk   = 1'b0;
    w_rst_n = 1'b0;
    w_num_a = 16'b0000_0000_0000_1010;
    w_num_b = 16'b0000_0000_0000_1001;
    #(CYCLE * 1);
    w_rst_n = 1'b1;
    #(CYCLE * 10);
    w_rst_n = 1'b0;
    w_num_a = 16'b0000_0000_0000_1010;
    w_num_b = 16'b0000_0000_0000_0101;
    #(CYCLE * 1);
    w_rst_n = 1'b1;
    #(CYCLE * 10);
    $finish;
end

mul_16bit_wallace mul_16bit_wallace_inst(
    .i_clk(w_clk),
    .i_rst_n(w_rst_n),
    .i_num_a(w_num_a),
    .i_num_b(w_num_b),
    .o_end(),
    .o_res(),
    .o_cry()
);

endmodule