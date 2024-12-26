/*
 * @Author      : myyerrol
 * @Date        : 2024-11-01 18:55:16
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-12-26 11:14:24
 * @Description : Check register.
 *
 * Copyright (c) 2024 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

module reg_chk #(
    parameter DATA_WIDTH = 32
) (
    input logic                      i_clk,
    input logic [DATA_WIDTH - 1 : 0] i_data
);

`ifdef REG_CHECK
    assert property (@(posedge i_clk) ((^i_data) !== 1'bx))
    else $fatal("\nError! X value is detected! This should never happen.\n");
`endif

endmodule
