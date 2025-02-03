/*
 * @Author      : myyerrol
 * @Date        : 2024-07-03 19:53:31
 * @LastEditors : myyerrol
 * @LastEditTime: 2025-02-03 14:24:37
 * @Description : nnbit ahead carry adder testbench
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`timescale 1ns / 1ps

module add_nnbit_ahead_serial_tb();

initial begin
    $dumpfile("build/add_nnbit_ahead_serial_tb.vcd");
    $dumpvars(0, add_nnbit_ahead_serial_tb);
end

parameter DATA_WIDTH = 8;

logic [DATA_WIDTH - 1 : 0] r_num_a;
logic [DATA_WIDTH - 1 : 0] r_num_b;
logic                      r_cry;

initial begin
        r_num_a = 8'b11110000; r_num_b = 8'b11110000; r_cry = 0;
    #10 r_num_a = 8'b11111111; r_num_b = 8'b11111111; r_cry = 0;
    #10 r_num_a = 8'b11111100; r_num_b = 8'b11111001; r_cry = 0;
    #10 r_num_a = 8'b11110111; r_num_b = 8'b11110110; r_cry = 0;
    #10 r_num_a = 8'b11110101; r_num_b = 8'b11110101; r_cry = 1;
    #10 r_num_a = 8'b11111110; r_num_b = 8'b11111001; r_cry = 1;
    #10 r_num_a = 8'b11110010; r_num_b = 8'b11110110; r_cry = 1;
    #10 r_num_a = 8'b11110110; r_num_b = 8'b11111100; r_cry = 1;
    #10 $finish;
end

add_nnbit_ahead_serial #(
    .DATA_WIDTH(DATA_WIDTH)
) u_add_nnbit_ahead_serial(
    .i_num_a(r_num_a),
    .i_num_b(r_num_b),
    .i_cry  (r_cry),
    .o_res  (),
    .o_cry  ()
);

endmodule
