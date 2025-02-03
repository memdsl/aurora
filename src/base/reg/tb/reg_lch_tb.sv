/*
 * @Author      : myyerrol
 * @Date        : 2024-11-02 18:10:12
 * @LastEditors : myyerrol
 * @LastEditTime: 2025-02-03 14:23:17
 * @Description : Testbench.
 *
 * Copyright (c) 2024 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

module reg_lch_tb();

initial begin
    $dumpfile("build/reg_lch_tb.vcd");
    $dumpvars(0, reg_lch_tb);
end

parameter DATA_WIDTH = 32;

logic                      r_en;
logic [DATA_WIDTH - 1 : 0] r_data;

initial begin
    r_en   = 1'b0;
    r_data = 32'hFFFF0000;
    #20;
    r_en   = 1'b0;
    r_data = 32'hFFFF00FF;
    #20;
    r_en   = 1'b1;
    r_data = 32'hFFFFFFFF;
    #20 $finish;
end

reg_lch #(
    .DATA_WIDTH(DATA_WIDTH)
) u_reg_lch(
    .i_en  (r_en),
    .i_data(r_data),
    .o_data()
);

endmodule
