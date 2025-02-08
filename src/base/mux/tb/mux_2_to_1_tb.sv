/*
 * @Author      : myyerrol
 * @Date        : 2024-11-02 18:10:12
 * @LastEditors : myyerrol
 * @LastEditTime: 2025-02-03 14:23:07
 * @Description : Testbench.
 *
 * Copyright (c) 2024 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

module mux_2_to_1_tb();

initial begin
    $dumpfile("build/mux_2_to_1_tb.vcd");
    $dumpvars(0, mux_2_to_1_tb);
end

parameter DATA_WIDTH = 32;

logic                      r_key;
logic [DATA_WIDTH - 1 : 0] r_val_a;
logic [DATA_WIDTH - 1 : 0] r_val_b;

initial begin
    r_key   = 1'b0;
    r_val_a = 32'h00000001;
    r_val_b = 32'h00000002;
    #20;
    r_key   = 1'b0;
    r_val_a = 32'h00000003;
    r_val_b = 32'h00000002;
    #20;
    r_key   = 1'b1;
    r_val_a = 32'h00000003;
    r_val_b = 32'h00000002;
    #20 $finish;
end

mux_2_to_1 #(
    .DATA_WIDTH(DATA_WIDTH)
) u_mux_2_1(
    .i_key  (r_key),
    .i_val_a(r_val_a),
    .i_val_b(r_val_b),
    .o_val  ()
);

endmodule
