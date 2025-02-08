/*
 * @Author      : myyerrol
 * @Date        : 2024-11-02 18:10:12
 * @LastEditors : myyerrol
 * @LastEditTime: 2025-02-03 14:23:10
 * @Description : Testbench.
 *
 * Copyright (c) 2024 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

module mux_4_to_1_tb();

initial begin
    $dumpfile("build/mux_4_to_1_tb.vcd");
    $dumpvars(0, mux_4_to_1_tb);
end

parameter DATA_WIDTH = 32;

logic        [             1 : 0] r_key;
logic [3 : 0][DATA_WIDTH - 1 : 0] r_val;

initial begin
    r_key    = 2'b00;
    r_val[0] = 32'h00000001;
    r_val[1] = 32'h00000002;
    r_val[2] = 32'h00000003;
    r_val[3] = 32'h00000004;
    #20;
    r_key    = 2'b01;
    #20;
    r_key    = 2'b10;
    #20;
    r_key    = 2'b11;
    #20 $finish;
end

mux_4_to_1 #(
    .DATA_WIDTH(DATA_WIDTH)
) u_mux_4_1(
    .i_key(r_key),
    .i_val(r_val),
    .o_val()
);

endmodule
