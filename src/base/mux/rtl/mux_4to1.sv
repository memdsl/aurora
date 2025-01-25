/*
 * @Author      : myyerrol
 * @Date        : 2025-02-02 19:14:02
 * @LastEditors : myyerrol
 * @LastEditTime: 2025-02-02 19:21:50
 * @Description : Multiplexer 4 to 1.
 *
 * Copyright (c) 2025 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

module mux_4to1 #(
    parameter DATA_WIDTH = 32
) (
    input  logic        [1              : 0] i_key,
    input  logic [3 : 0][DATA_WIDTH - 1 : 0] i_val,
    output logic        [DATA_WIDTH - 1 : 0] o_val
);

    mux_key_def #(
        .KEY_NUM  (4),
        .KEY_WIDTH(2),
        .VAL_WIDTH(DATA_WIDTH)
    ) u_mux_key_def(
        .i_key    (i_key),
        .i_val_def({DATA_WIDTH{1'h0}}),
        .i_lut    ({
            2'b00, i_val[0],
            2'b01, i_val[1],
            2'b10, i_val[2],
            2'b11, i_val[3]
        }),
        .o_val    (o_val)
    );

endmodule
