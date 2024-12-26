/*
 * @Author      : myyerrol
 * @Date        : 2024-12-26 11:04:16
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-12-26 11:07:31
 * @Description : Register without reset, without mode, with enable.
 *
 * Copyright (c) 2024 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

module reg_rst_n_mode_n_en_y #(
    parameter DATA_WIDTH = 32
) (
    input  logic                      i_clk,
    input  logic                      i_en,
    input  logic [DATA_WIDTH - 1 : 0] i_data,
    output logic [DATA_WIDTH - 1 : 0] o_data
);

    logic [DATA_WIDTH - 1 : 0] r_data;

    always_ff @(posedge i_clk) begin
        if (i_en) begin
            r_data <= #`REG_DELAY_CYCLE i_data;
        end
        else begin
            r_data <= #`REG_DELAY_CYCLE r_data;
        end
    end

    assign o_data = r_data;

`ifdef REG_CHECK
    reg_chk #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u_reg_check_data_x(
        .i_clk (i_clk),
        .i_data(i_data)
    );
`endif

endmodule
