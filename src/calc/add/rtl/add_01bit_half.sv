/*
 * @Author      : myyerrol
 * @Date        : 2024-06-22 20:56:45
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-12-18 03:57:16
 * @Description : 01bit half adder
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`timescale 1ns / 1ps

/**
 * @description: 01bit half adder
 * @param {logic} i_num_a: Number a
 * @param {logic} i_num_b: Number b
 * @param {logic} o_res  : Result
 * @param {logic} o_cry  : Carry
 */
module add_01bit_half(
    input  logic i_num_a,
    input  logic i_num_b,
    output logic o_res,
    output logic o_cry
);

    /** Output result and carry bits. */
    assign o_res = i_num_a ^ i_num_b;
    assign o_cry = i_num_a & i_num_b;

endmodule
