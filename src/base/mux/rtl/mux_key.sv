/*
 * @Author      : myyerrol
 * @Date        : 2025-02-02 19:03:42
 * @LastEditors : myyerrol
 * @LastEditTime: 2025-02-02 19:21:01
 * @Description : Multiplexer key.
 *
 * Copyright (c) 2025 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

module mux_key #(
    parameter KEY_NUM   = 2,
    parameter KEY_WIDTH = 1,
    parameter VAL_WIDTH = 1
) (
    input  logic [KEY_WIDTH                         - 1 : 0] i_key,
    input  logic [KEY_NUM * (KEY_WIDTH + VAL_WIDTH) - 1 : 0] i_lut,
    output logic [VAL_WIDTH                         - 1 : 0] o_val
);

    mux #(
        .KEY_NUM  (KEY_NUM),
        .KEY_WIDTH(KEY_WIDTH),
        .VAL_WIDTH(VAL_WIDTH),
        .HAS_DEF  (0)
    ) u_mux(
        .i_key    (i_key),
        .i_val_def({VAL_WIDTH{1'h0}}),
        .i_lut    (i_lut),
        .o_val    (o_val)
    );

endmodule
