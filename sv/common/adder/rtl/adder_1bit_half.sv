/*
 * @Author      : myyerrol
 * @Date        : 2024-06-22 20:56:45
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-06-28 21:16:25
 * @FilePath    : /memdsl-cpu/meteor/ip/sv/common/adder/rtl/adder_1bit_half.sv
 * @Description : 1bit half adder
 *
 *  Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

/**
 * @description: 1bit half adder
 * @param i_num_a {logic} Number a
 * @param i_num_b {logic} Number b
 * @param o_res   {logic} Result
 * @param o_cry   {logic} Carry
 */
module adder_1bit_half(
    input  logic i_num_a,
    input  logic i_num_b,
    output logic o_res,
    output logic o_cry
);

    /** Output result and carry bits. */
    assign { o_cry, o_res } = i_num_a + i_num_b;

endmodule
