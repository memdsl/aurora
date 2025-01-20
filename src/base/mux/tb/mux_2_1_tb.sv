/*
 * @Author      : myyerrol
 * @Date        : 2024-11-02 18:10:12
 * @LastEditors : myyerrol
 * @LastEditTime: 2025-02-02 19:54:22
 * @Description : Testbench.
 *
 * Copyright (c) 2024 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

module mux_2_1_tb();

initial begin
    $dumpfile("build/mux_2_1_tb.vcd");
    $dumpvars(0, mux_2_1_tb);
end

parameter DATA_WIDTH = 32;

logic                      w_key;
logic [DATA_WIDTH - 1 : 0] w_val_a;
logic [DATA_WIDTH - 1 : 0] w_val_b;

initial begin
    w_key   = 1'b0;
    w_val_a = 32'h00000001;
    w_val_b = 32'h00000002;
    #20;
    w_key   = 1'b0;
    w_val_a = 32'h00000003;
    w_val_b = 32'h00000002;
    #20;
    w_key   = 1'b1;
    w_val_a = 32'h00000003;
    w_val_b = 32'h00000002;
    #20 $finish;
end

mux_2_1 #(
    .DATA_WIDTH(DATA_WIDTH)
) u_mux_2_1(
    .i_key  (w_key),
    .i_val_a(w_val_a),
    .i_val_b(w_val_b),
    .o_val  ()
);

endmodule
