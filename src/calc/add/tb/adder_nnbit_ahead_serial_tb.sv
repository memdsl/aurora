/*
 * @Author      : myyerrol
 * @Date        : 2024-07-03 19:53:31
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-09-08 18:23:04
 * @FilePath    : /memdsl/aurora/src/common/adder/tb/add_nnbit_ahead_serial_tb.sv
 * @Description :nnbit ahead carry adder testbench
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */


`timescale 1ns / 1ps

module add_nnbit_ahead_serial_tb();

initial begin
    $dumpfile("build/add_nnbit_ahead_serial.vcd");
    $dumpvars(0, add_nnbit_ahead_serial_tb);
end

parameter DATA_WIDTH = 8;

logic [DATA_WIDTH - 1 : 0] w_num_a;
logic [DATA_WIDTH - 1 : 0] w_num_b;
logic                      w_cry;

initial begin
        w_num_a = 8'b11110000; w_num_b = 8'b11110000; w_cry = 0;
    #10 w_num_a = 8'b11111111; w_num_b = 8'b11111111; w_cry = 0;
    #10 w_num_a = 8'b11111100; w_num_b = 8'b11111001; w_cry = 0;
    #10 w_num_a = 8'b11110111; w_num_b = 8'b11110110; w_cry = 0;
    #10 w_num_a = 8'b11110101; w_num_b = 8'b11110101; w_cry = 1;
    #10 w_num_a = 8'b11111110; w_num_b = 8'b11111001; w_cry = 1;
    #10 w_num_a = 8'b11110010; w_num_b = 8'b11110110; w_cry = 1;
    #10 w_num_a = 8'b11110110; w_num_b = 8'b11111100; w_cry = 1;
    #10 $finish;
end

add_nnbit_ahead_serial #(
    .DATA_WIDTH(DATA_WIDTH)
) u_add_nnbit_ahead_serial(
    .i_num_a(w_num_a),
    .i_num_b(w_num_b),
    .i_cry(w_cry),
    .o_res(),
    .o_cry()
);

endmodule
