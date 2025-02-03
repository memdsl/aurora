/*
 * @Author      : myyerrol
 * @Date        : 2024-06-28 14:52:18
 * @LastEditors : myyerrol
 * @LastEditTime: 2025-02-03 14:24:40
 * @Description : nnbit serial carry adder testbench
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`timescale 1ns / 1ps

module add_nnbit_serial_tb();

initial begin
    $dumpfile("build/add_nnbit_serial_tb.vcd");
    $dumpvars(0, add_nnbit_serial_tb);
end

parameter DATA_WIDTH = 4;

logic [DATA_WIDTH - 1 : 0] r_num_a;
logic [DATA_WIDTH - 1 : 0] r_num_b;
logic                      r_cry;

initial begin
        r_num_a = 4'b0000; r_num_b = 4'b0000; r_cry = 0;
    #10 r_num_a = 4'b1111; r_num_b = 4'b1111; r_cry = 0;
    #10 r_num_a = 4'b1100; r_num_b = 4'b1001; r_cry = 0;
    #10 r_num_a = 4'b0111; r_num_b = 4'b0110; r_cry = 0;
    #10 r_num_a = 4'b0101; r_num_b = 4'b0101; r_cry = 1;
    #10 r_num_a = 4'b1110; r_num_b = 4'b1001; r_cry = 1;
    #10 r_num_a = 4'b0010; r_num_b = 4'b0110; r_cry = 1;
    #10 r_num_a = 4'b0110; r_num_b = 4'b1100; r_cry = 1;
    #10 $finish;
end

add_nnbit_serial #(
    .DATA_WIDTH(DATA_WIDTH)
) u_add_nnbit_serial(
    .i_num_a(r_num_a),
    .i_num_b(r_num_b),
    .i_cry  (r_cry),
    .o_res  (),
    .o_cry  ()
);

endmodule
