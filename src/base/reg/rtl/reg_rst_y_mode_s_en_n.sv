/*
 * @Author      : myyerrol
 * @Date        : 2024-12-26 11:05:42
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-12-26 11:07:04
 * @Description : Register with reset, with synchronous mode, without enable.
 *
 * Copyright (c) 2024 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

module reg_rst_y_mode_s_en_n #(
    parameter DATA_WIDTH = 32
) (
    input  logic                      i_clk,
    input  logic                      i_rst_n,
    input  logic [DATA_WIDTH - 1 : 0] i_data,
    output logic [DATA_WIDTH - 1 : 0] o_data
);

    logic [DATA_WIDTH - 1 : 0] r_data;

    always_ff @(posedge i_clk) begin
        if (!i_rst_n) begin
            r_data <= {DATA_WIDTH{1'b0}};
        end
        else begin
            r_data <= #`REG_DELAY_CYCLE i_data;
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
