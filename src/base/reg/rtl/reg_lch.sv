/*
 * @Author      : myyerrol
 * @Date        : 2024-12-26 11:11:01
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-12-26 11:11:10
 * @Description : Register with latch.
 *
 * Copyright (c) 2024 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

// verilator lint_off LATCH
module reg_lch #(
    parameter DATA_WIDTH = 32
) (
    input  logic                      i_en,
    input  logic [DATA_WIDTH - 1 : 0] i_data,
    output logic [DATA_WIDTH - 1 : 0] o_data
);

    reg [DATA_WIDTH - 1 : 0] r_data;

    always_comb begin
        if (i_en) begin
            r_data = i_data;
        end
    end

    assign o_data = r_data;

`ifdef REG_CHECK
    assert property (i_en !== 1'bx)
    else $fatal("\nError! X value is detected! This should never happen.\n");
`endif

endmodule
