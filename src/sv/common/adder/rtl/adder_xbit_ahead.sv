/*
 * @Author      : myyerrol
 * @Date        : 2024-06-28 14:41:49
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-06-30 22:57:38
 * @FilePath    : /memdsl-cpu/aurora/src/sv/common/adder/rtl/adder_xbit_ahead.sv
 * @Description : xbit ahead carry adder
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

/**
 * @description: xbit ahead carry adder
 * @param i_num_a {logic} Number a
 * @param i_num_b {logic} Number b
 * @param i_cry   {logic} Carry from lowest bit
 * @param o_res   {logic} Result
 * @param o_cry   {logic} Carry to highest bit
 */
module adder_xbit_ahead #(
    parameter DATA_WIDTH = 8
) (
    input  logic [DATA_WIDTH - 1 : 0] i_num_a,
    input  logic [DATA_WIDTH - 1 : 0] i_num_b,
    input  logic                  i_cry,
    output logic [DATA_WIDTH - 1 : 0] o_res,
    output logic                  o_cry
);

    /** Intermediate carry bits */
    logic [DATA_WIDTH - 1 : 0] w_cry_imd;
    /** Temporary carry bits */
    logic [DATA_WIDTH - 1 : 0] w_cry;
    /** Temporary result */
    logic [DATA_WIDTH - 1 : 0] w_res;

    assign w_cry = { w_cry_imd[DATA_WIDTH - 2 : 0], i_cry };

    /** Calculate temporary carry bits. */
    generate
        genvar i;
        for (i = 0; i < DATA_WIDTH; i = i + 1)
        begin: calc_carry_temp
            assign w_cry_imd[i] = (i_num_a[i] & i_num_b[i]) ||
                                 ((i_num_a[i] | i_num_b[i]) & w_cry[i]);
        end
    endgenerate

    /** Calculate result.*/
    generate
        for (i = 0; i < DATA_WIDTH; i = i + 1)
        begin: calc_result
            assign w_res[i] = i_num_a[i] ^ i_num_b[i] ^ w_cry[i];
        end
    endgenerate

    /** Output result and carry bits. */
    assign o_res = w_res;
    assign o_cry = w_cry_imd[DATA_WIDTH - 1];

endmodule
