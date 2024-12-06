/*
 * @Author      : myyerrol
 * @Date        : 2024-06-28 14:41:49
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-07-08 20:56:56
 * @FilePath    : /memdsl/aurora/src/sv/common/adder/rtl/add_04bit_ahead.sv
 * @Description : 04bit ahead carry adder
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

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

    /** Temporary result */
    logic [3 : 0] w_res;
    /** Intermediate carry bits */
    logic [3 : 0] w_cry_imd;
    /** Temporary carry bits */
    logic [3 : 0] w_cry;

    assign w_cry = { w_cry_imd[4 - 2 : 0], i_cry };

    /** Calculate result.*/
    generate
        genvar i;
        for (i = 0; i < 4; i = i + 1) begin
            assign w_res[i] = i_num_a[i] ^ i_num_b[i] ^ w_cry[i];
        end
    endgenerate

    /** Calculate temporary carry bits. */
    generate
        for (i = 0; i < 4; i = i + 1) begin
            assign w_cry_imd[i] = (i_num_a[i] & i_num_b[i]) ||
                                 ((i_num_a[i] | i_num_b[i]) & w_cry[i]);
        end
    endgenerate

    /** Output result and carry bits. */
    assign o_res = w_res;
    assign o_cry = w_cry_imd[3];

endmodule
