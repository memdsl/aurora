/*
 * @Author      : myyerrol
 * @Date        : 2025-02-02 19:13:44
 * @LastEditors : myyerrol
 * @LastEditTime: 2025-02-08 09:45:59
 * @Description : Multiplexer 2 to 1.
 *
 * Copyright (c) 2025 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

module mux_2_to_1 #(
    parameter DATA_WIDTH = 32
) (
    input  logic                      i_key,
    input  logic [DATA_WIDTH - 1 : 0] i_val_a,
    input  logic [DATA_WIDTH - 1 : 0] i_val_b,
    output logic [DATA_WIDTH - 1 : 0] o_val
);

    mux_key_def #(
        .KEY_NUM  (2),
        .KEY_WIDTH(1),
        .VAL_WIDTH(DATA_WIDTH)
    ) u_mux_key_def(
        .i_key    (i_key),
        .i_val_def({DATA_WIDTH{1'h0}}),
        .i_lut    ({
            1'b0, i_val_a,
            1'b1, i_val_b
        }),
        .o_val    (o_val)
    );

endmodule
