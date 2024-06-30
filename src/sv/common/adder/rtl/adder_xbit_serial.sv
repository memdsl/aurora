/*
 * @Author      : myyerrol
 * @Date        : 2024-06-24 01:15:01
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-06-30 22:55:56
 * @FilePath    : /memdsl-cpu/aurora/src/sv/common/adder/rtl/adder_xbit_serial.sv
 * @Description : xbit serial carry adder
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`include "adder_1bit_full.sv"

/**
 * @description: xbit serial carry adder
 * @param i_num_a {logic} Number a
 * @param i_num_b {logic} Number b
 * @param i_cry   {logic} Carry from lowest bit
 * @param o_res   {logic} Result
 * @param o_cry   {logic} Carry to highest bit
 */
module adder_xbit_serial #(
    parameter DATA_WIDTH = 8
) (
    input  logic [DATA_WIDTH - 1 : 0] i_num_a,
    input  logic [DATA_WIDTH - 1 : 0] i_num_b,
    input  logic                      i_cry,
    output logic [DATA_WIDTH - 1 : 0] o_res,
    output logic                      o_cry
);

    /** Temporary result */
    logic [DATA_WIDTH - 1 : 0] w_res;
    /** Temporary carry bits */
    logic [DATA_WIDTH - 1 : 0] w_cry;

    /**
     * Instantiate multiple 1bit full adders according to DATA_WIDTH to build a
     * serial full adder, becaouse the sum of each bit must wait until the
     * carry of the lower bit is generated before it can be established, so the
     * execution efficiency of serial full adder is not high.
     */
    generate
        genvar i;
        for (i = 0; i < DATA_WIDTH; i = i + 1)
        begin: adder_xbit_serial
            adder_1bit_full adder_1bit_full_inst(
                .i_num_a(i_num_a[i]),
                .i_num_b(i_num_b[i]),
                .i_cry((i == 0) ? i_cry : w_cry[i - 1]),
                .o_res(w_res[i]),
                .o_cry(w_cry[i])
            );
        end
    endgenerate

    /** Output result and carry bits. */
    assign o_res = w_res;
    assign o_cry = w_cry[DATA_WIDTH - 1];

endmodule
