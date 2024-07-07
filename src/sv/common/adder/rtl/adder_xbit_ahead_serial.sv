/*
 * @Author      : myyerrol
 * @Date        : 2024-07-03 18:18:33
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-07-03 20:16:12
 * @FilePath    : /memdsl/aurora/src/sv/common/adder/rtl/adder_xbit_ahead_serial.sv
 * @Description : xbit ahead carry serial adder
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`include "adder_4bit_ahead.sv"

/**
 * @description: 4bit ahead carry serial adder
 * @param {logic} i_num_a: Number a
 * @param {logic} i_num_b: Number b
 * @param {logic} i_cry  : Carry from lowest bit
 * @param {logic} o_res  : Result
 * @param {logic} o_cry  : Carry to highest bit
 */
module adder_xbit_ahead_serial #(
    parameter DATA_WIDTH = 8
) (
    input  logic [DATA_WIDTH - 1 : 0] i_num_a,
    input  logic [DATA_WIDTH - 1 : 0] i_num_b,
    input  logic                      i_cry,
    output logic [DATA_WIDTH - 1 : 0] o_res,
    output logic                      o_cry
);

    /** Temporary result */
    logic [DATA_WIDTH     - 1 : 0] w_res;
    /** Temporary carry bits */
    logic [DATA_WIDTH / 4 - 1 : 0] w_cry;

    generate
        genvar i;
        for (i = 0; i < DATA_WIDTH / 4; i = i + 1)
        begin: adder_xbit_ahead_serial
            adder_4bit_ahead adder_4bit_ahead_inst(
                .i_num_a(i_num_a[i * 4 + 3 : i * 4]),
                .i_num_b(i_num_b[i * 4 + 3 : i * 4]),
                .i_cry((i == 0) ? i_cry : w_cry[i - 1]),
                .o_res(w_res[i * 4 + 3 : i * 4]),
                .o_cry(w_cry[i])
            );
        end
    endgenerate

    /** Output result and carry bits. */
    assign o_res = w_res;
    assign o_cry = w_cry[DATA_WIDTH / 4 - 1];

endmodule
