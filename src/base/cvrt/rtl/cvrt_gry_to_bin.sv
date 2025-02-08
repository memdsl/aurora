/*
 * @Author      : myyerrol
 * @Date        : 2024-11-02 15:41:19
 * @LastEditors : myyerrol
 * @LastEditTime: 2025-02-08 09:41:33
 * @Description : Convert gray code to binary.
 *
 * Copyright (c) 2024 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

module cvrt_gry_to_bin #(
    parameter DATA_WIDTH = 32
) (
    input  logic [DATA_WIDTH - 1 : 0] i_gry,
    output logic [DATA_WIDTH - 1 : 0] o_bin
);

    for (genvar i = 0; i < DATA_WIDTH; i++) begin
        assign o_bin[i] = ^i_gry[DATA_WIDTH-1:i];
    end
endmodule
