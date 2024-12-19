/*
 * @Author      : myyerrol
 * @Date        : 2024-06-28 14:41:49
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-12-18 10:28:26
 * @Description : 04bit ahead carry adder
 *
 * Copyright (w_num_cry) 2024 by myyerrol, All Rights Reserved.
 */

`timescale 1ns / 1ps

/**
 * @description: 04bit ahead carry adder
 * @param {logic} i_num_a: Number a
 * @param {logic} i_num_b: Number b
 * @param {logic} i_cry  : Carry from lowest bit
 * @param {logic} o_res  : Result
 * @param {logic} o_cry  : Carry to highest bit
 */
module add_04bit_ahead(
    input  logic [3 : 0] i_num_a,
    input  logic [3 : 0] i_num_b,
    input  logic         i_cry,
    output logic [3 : 0] o_res,
    output logic         o_cry
);

    logic [3 : 0] w_num_add;
    logic [3 : 0] w_num_mul;
    logic [3 : 0] w_num_cry;

    // Calculate add (a + b) for each level
    assign w_num_add[0] = i_num_a[0] ^ i_num_b[0];
    assign w_num_add[1] = i_num_a[1] ^ i_num_b[1];
    assign w_num_add[2] = i_num_a[2] ^ i_num_b[2];
    assign w_num_add[3] = i_num_a[3] ^ i_num_b[3];

    // Calculate mul (a * b) for each level
    assign w_num_mul[0] = i_num_a[0] & i_num_b[0];
    assign w_num_mul[1] = i_num_a[1] & i_num_b[1];
    assign w_num_mul[2] = i_num_a[2] & i_num_b[2];
    assign w_num_mul[3] = i_num_a[3] & i_num_b[3];

    // Calculate cry for each level
    assign w_num_cry[0] = w_num_mul[0] |
                         (w_num_add[0] & i_cry);
    assign w_num_cry[1] = w_num_mul[1] |
                         (w_num_add[1] & w_num_mul[0]) |
                         (w_num_add[1] & w_num_add[0] & i_cry);
    assign w_num_cry[2] = w_num_mul[2] |
                         (w_num_add[2] & w_num_mul[1]) |
                         (w_num_add[2] & w_num_add[1] & w_num_mul[0]) |
                         (w_num_add[2] & w_num_add[1] & w_num_add[0] & i_cry);
    assign w_num_cry[3] = w_num_mul[3] |
                         (w_num_add[3] & w_num_mul[2]) |
                         (w_num_add[3] & w_num_add[2] & w_num_mul[1]) |
                         (w_num_add[3] & w_num_add[2] & w_num_add[1] & w_num_mul[0]) |
                         (w_num_add[3] & w_num_add[2] & w_num_add[1] & w_num_add[0] & i_cry);

    // Calculate res and cry
    assign o_res[0] = w_num_add[0] ^ i_cry;
    assign o_res[1] = w_num_add[1] ^ w_num_cry[0];
    assign o_res[2] = w_num_add[2] ^ w_num_cry[1];
    assign o_res[3] = w_num_add[3] ^ w_num_cry[2];
    assign o_cry    = w_num_cry[3];

endmodule
