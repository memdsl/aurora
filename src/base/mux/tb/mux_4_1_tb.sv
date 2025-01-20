/*
 * @Author      : myyerrol
 * @Date        : 2024-11-02 18:10:12
 * @LastEditors : myyerrol
 * @LastEditTime: 2025-02-02 19:54:19
 * @Description : Testbench.
 *
 * Copyright (c) 2024 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

module mux_4_1_tb();

initial begin
    $dumpfile("build/mux_4_1_tb.vcd");
    $dumpvars(0, mux_4_1_tb);
end

parameter DATA_WIDTH = 32;

logic        [             1 : 0] w_key;
logic [3 : 0][DATA_WIDTH - 1 : 0] w_val;

initial begin
    w_key    = 2'b00;
    w_val[0] = 32'h00000001;
    w_val[1] = 32'h00000002;
    w_val[2] = 32'h00000003;
    w_val[3] = 32'h00000004;
    #20;
    w_key    = 2'b01;
    #20;
    w_key    = 2'b10;
    #20;
    w_key    = 2'b11;
    #20 $finish;
end

mux_4_1 #(
    .DATA_WIDTH(DATA_WIDTH)
) u_mux_4_1(
    .i_key(w_key),
    .i_val(w_val),
    .o_val()
);

endmodule
