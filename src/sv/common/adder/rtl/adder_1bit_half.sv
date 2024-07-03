/*
 * @Author      : myyerrol
 * @Date        : 2024-06-22 20:56:45
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-07-02 12:35:34
 * @FilePath    : /memdsl-cpu/aurora/src/sv/common/adder/rtl/adder_1bit_half.sv
 * @Description : 1bit half adder
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

/**
 * @description: 1bit half adder
 * @param {logic} i_num_a: Number a
 * @param {logic} i_num_b: Number b
 * @param {logic} o_res  : Result
 * @param {logic} o_cry  : Carry
 */
module adder_1bit_half(
    input  logic i_num_a,
    input  logic i_num_b,
    output logic o_res,
    output logic o_cry
);

    /** Output result and carry bits. */
    // assign { o_cry, o_res } = i_num_a + i_num_b;
    assign o_res = i_num_a ^ i_num_b;
    assign o_cry = i_num_a & i_num_b;

endmodule
