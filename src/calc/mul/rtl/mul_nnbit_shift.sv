/*
 * @Author      : myyerrol
 * @Date        : 2024-07-02 12:49:46
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-12-19 15:11:25
 * @Description : nnbit shift multiplier
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`timescale 1ns / 1ps

module mul_nnbit_shift #(
    parameter DATA_WIDTH = 8
) (
    input  logic                          i_clk,
    input  logic                          i_rst_n,
    input  logic [DATA_WIDTH - 1     : 0] i_num_x,
    input  logic [DATA_WIDTH - 1     : 0] i_num_y,
    output logic                          o_end,
    output logic [DATA_WIDTH * 2 - 1 : 0] o_res
);

    logic [DATA_WIDTH * 2 - 1 : 0] r_num_x;
    logic [DATA_WIDTH     - 1 : 0] r_num_y;
    logic [DATA_WIDTH * 2 - 1 : 0] r_res;

    logic [DATA_WIDTH * 2 - 1 : 0] w_res;

    int c_cnt;

    always_ff @(posedge i_clk) begin
        if (!i_rst_n) begin
            r_num_x <= {{DATA_WIDTH{i_num_x[DATA_WIDTH - 1]}}, i_num_x};
            r_num_y <= i_num_y;
            r_res   <= {(DATA_WIDTH * 2){1'b0}};
            c_cnt   <= 0;
        end
        else begin
            if (c_cnt == DATA_WIDTH) begin
                o_end <= 1'b1;
                o_res <= r_res + (~w_res + 1'b1);
                c_cnt <= c_cnt;
            end
            else begin
                o_end   <= 1'b0;
                o_res   <= {(DATA_WIDTH * 2){1'b0}};
                r_res   <= r_res + w_res;
                r_num_x <= (r_num_x << 1);
                r_num_y <= (r_num_y >> 1);
                c_cnt   <= c_cnt + 1'b1;
            end
        end
    end

    assign w_res = (r_num_y[0]) ? r_num_x : {(DATA_WIDTH * 2){1'b0}};

endmodule
