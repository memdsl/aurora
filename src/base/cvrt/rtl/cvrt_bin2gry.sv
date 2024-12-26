/*
 * @Author      : myyerrol
 * @Date        : 2024-11-02 15:41:19
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-12-26 15:04:58
 * @Description : Convert binary to gray code.
 *
 * Copyright (c) 2024 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

module cvrt_bin2gry #(
    parameter DATA_WIDTH = 32
) (
    input  logic [DATA_WIDTH - 1 : 0] i_bin,
    output logic [DATA_WIDTH - 1 : 0] o_gry
);

    assign o_gry = i_bin ^ (i_bin >> 1);

endmodule
