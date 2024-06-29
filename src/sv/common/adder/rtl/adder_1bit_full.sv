/*
 * @Author      : myyerrol
 * @Date        : 2024-06-22 20:56:57
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-06-29 10:47:33
 * @FilePath    : /memdsl-cpu/meteor/ip/src/sv/common/adder/rtl/adder_1bit_full.sv
 * @Description : 1bit full adder
 *
 *  Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

/**
 * @description: 1bit full adder
 * @param i_num_a {logic} Number a
 * @param i_num_b {logic} Number b
 * @param i_cry   {logic} Carry from low bit
 * @param o_res   {logic} Result
 * @param o_cry   {logic} Carry to high bit
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
