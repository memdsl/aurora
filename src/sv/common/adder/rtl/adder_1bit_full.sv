/*
 * @Author      : myyerrol
 * @Date        : 2024-06-22 20:56:57
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-07-02 12:36:13
 * @FilePath    : /memdsl-cpu/aurora/src/sv/common/adder/rtl/adder_1bit_full.sv
 * @Description : 1bit full adder
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

/**
 * @description: 1bit full adder
 * @param {logic} i_num_a: Number a
 * @param {logic} i_num_b: Number b
 * @param {logic} i_cry  : Carry from low bit
 * @param {logic} o_res  : Result
 * @param {logic} o_cry  : Carry to high bit
 */
module adder_1bit_full (
    input  logic i_num_a,
    input  logic i_num_b,
    input  logic i_cry,
    output logic o_res,
    output logic o_cry
);

    /** Output result and carry bits. */
    assign { o_cry, o_res } = i_num_a + i_num_b + i_cry;

endmodule
