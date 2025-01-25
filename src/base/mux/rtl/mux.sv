/*
 * @Author      : myyerrol
 * @Date        : 2025-02-02 19:03:31
 * @LastEditors : myyerrol
 * @LastEditTime: 2025-02-02 19:20:56
 * @Description : Multiplexer core.
 *
 * Copyright (c) 2025 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

module mux #(
    parameter KEY_NUM   = 2,
    parameter KEY_WIDTH = 1,
    parameter VAL_WIDTH = 1,
    parameter HAS_DEF   = 0
) (
    input  logic [KEY_WIDTH                         - 1 : 0] i_key,
    input  logic [VAL_WIDTH                         - 1 : 0] i_val_def,
    input  logic [KEY_NUM * (KEY_WIDTH + VAL_WIDTH) - 1 : 0] i_lut,
    output logic [VAL_WIDTH                         - 1 : 0] o_val
);

    localparam MAP_WIDTH = KEY_WIDTH + VAL_WIDTH;

    logic [MAP_WIDTH - 1 : 0] w_map [KEY_NUM - 1 : 0];
    logic [KEY_WIDTH - 1 : 0] w_key [KEY_NUM - 1 : 0];
    logic [VAL_WIDTH - 1 : 0] w_val [KEY_NUM - 1 : 0];

    genvar n;
    generate
        for (n = 0; n < KEY_NUM; n = n + 1) begin
            assign w_map[n] = i_lut[MAP_WIDTH * (n + 1) - 1 : MAP_WIDTH * n];
            assign w_val[n] = w_map[n][VAL_WIDTH - 1 : 0];
            assign w_key[n] = w_map[n][MAP_WIDTH - 1 : VAL_WIDTH];
        end
    endgenerate

    reg [VAL_WIDTH - 1 : 0] r_lut;
    reg                     r_hit;

    always @(*) begin
        r_lut = 0;
        r_hit = 0;
        for (integer i = 0; i < KEY_NUM; i = i + 1) begin
            r_lut = r_lut | ({VAL_WIDTH{i_key == w_key[i]}} & w_val[i]);
            r_hit = r_hit | (i_key == w_key[i]);
        end
        if (!HAS_DEF) begin
            o_val = r_lut;
        end
        else begin
            o_val = (r_hit ? r_lut : i_val_def);
        end
    end

endmodule
