/*
 * @Author      : myyerrol
 * @Date        : 2025-02-02 19:04:59
 * @LastEditors : myyerrol
 * @LastEditTime: 2025-02-02 19:21:18
 * @Description : Multiplexer key defines.
 *
 * Copyright (c) 2025 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

module mux_key_def #(
    parameter KEY_NUM   = 2,
    parameter KEY_WIDTH = 1,
    parameter VAL_WIDTH = 1
) (
    input  [KEY_WIDTH                         - 1 : 0] i_key,
    input  [VAL_WIDTH                         - 1 : 0] i_val_def,
    input  [KEY_NUM * (KEY_WIDTH + VAL_WIDTH) - 1 : 0] i_lut,
    output [VAL_WIDTH                         - 1 : 0] o_val
);

    mux #(
        .KEY_NUM  (KEY_NUM),
        .KEY_WIDTH(KEY_WIDTH),
        .VAL_WIDTH(VAL_WIDTH),
        .HAS_DEF  (1)
    ) u_mux(
        .i_key    (i_key),
        .i_val_def(i_val_def),
        .i_lut    (i_lut),
        .o_val    (o_val)
    );

endmodule
