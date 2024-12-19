/*
 * @Author      : myyerrol
 * @Date        : 2024-07-07 12:43:56
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-12-19 15:32:34
 * @Description : 01bit wallace tree for adding 8 numbers
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`timescale 1ns / 1ps

module mul_01bitx08_wallace(
    input  logic [7 : 0] i_num,
    input  logic [5 : 0] i_cry_06bit,
    output logic [5 : 0] o_cry_06bit,
    output logic         o_res,
    output logic         o_cry
);

    logic w_res_00;
    logic w_res_01;
    logic w_res_02;
    logic w_res_10;
    logic w_res_11;
    logic w_res_20;
    logic w_res_30;

    add_01bit_full add_01bit_full_00(
        .i_num_a(i_num[0]),
        .i_num_b(i_num[1]),
        .i_cry  (i_num[2]),
        .o_res  (w_res_00),
        .o_cry  (o_cry_06bit[0])
    );

    add_01bit_full add_01bit_full_01(
        .i_num_a(i_num[3]),
        .i_num_b(i_num[4]),
        .i_cry  (i_num[5]),
        .o_res  (w_res_01),
        .o_cry  (o_cry_06bit[1])
    );

    add_01bit_full add_01bit_full_02(
        .i_num_a(i_num[6]),
        .i_num_b(i_num[7]),
        .i_cry  (1'b0),
        .o_res  (w_res_02),
        .o_cry  (o_cry_06bit[2])
    );

    add_01bit_full add_01bit_full_10(
        .i_num_a(w_res_00),
        .i_num_b(w_res_01),
        .i_cry  (w_res_02),
        .o_res  (w_res_10),
        .o_cry  (o_cry_06bit[3])
    );

    add_01bit_full add_01bit_full_11(
        .i_num_a(i_cry_06bit[0]),
        .i_num_b(i_cry_06bit[1]),
        .i_cry  (i_cry_06bit[2]),
        .o_res  (w_res_11),
        .o_cry  (o_cry_06bit[4])
    );

    add_01bit_full add_01bit_full_20(
        .i_num_a(w_res_10),
        .i_num_b(w_res_11),
        .i_cry  (i_cry_06bit[3]),
        .o_res  (w_res_20),
        .o_cry  (o_cry_06bit[5])
    );

    add_01bit_full add_01bit_full_30(
        .i_num_a(w_res_20),
        .i_num_b(i_cry_06bit[4]),
        .i_cry  (i_cry_06bit[5]),
        .o_res  (o_res),
        .o_cry  (o_cry)
    );

endmodule
