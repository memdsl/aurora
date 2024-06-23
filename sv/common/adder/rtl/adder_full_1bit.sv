/*
 * @Author      : myyerrol
 * @Date        : 2024-06-22 20:56:57
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-06-24 01:10:04
 * @FilePath    : /memdsl-cpu/meteor/ip/sv/common/adder/rtl/adder_full_1bit.sv
 * @Description : 1bit Full Adder
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
module adder_full_1bit (
    input  logic i_num_a,
    input  logic i_num_b,
    input  logic i_cry,
    output logic o_res,
    output logic o_cry
);

    assign { o_cry, o_res } = i_num_a + i_num_b + i_cry;

endmodule
