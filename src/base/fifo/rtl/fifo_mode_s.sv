/*
 * @Author      : myyerrol
 * @Date        : 2024-11-02 15:22:27
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-12-26 14:51:59
 * @Description : FIFO with synchronous mode.
 *
 * Copyright (c) 2024 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

module fifo_mode_s #(
    parameter DATA_WIDTH = 32,
    parameter FIFO_DEPTH =  8,
    parameter PTRS_WIDTH = $clog2(FIFO_DEPTH)
) (
    input  logic                      i_clk,
    input  logic                      i_rst_n,

    input  logic                      i_wr_en,
    input  logic [DATA_WIDTH - 1 : 0] i_wr_data,
    output logic                      o_wr_full,

    input  logic                      i_rd_en,
    output logic [DATA_WIDTH - 1 : 0] o_rd_data,
    output logic                      o_rd_empty
);

    logic [DATA_WIDTH - 1 : 0] r_sram[FIFO_DEPTH - 1 : 0];

    logic [PTRS_WIDTH - 1 : 0] r_wr_ptr;
    logic [PTRS_WIDTH - 1 : 0] r_rd_ptr;

    logic [PTRS_WIDTH     : 0] r_cnt;

    // Counter
    always_ff @(posedge i_clk or negedge i_rst_n) begin
        if (!i_rst_n) begin
            r_cnt <= {(PTRS_WIDTH + 1){1'b0}};
        end
        else if (i_wr_en && !o_wr_full && i_rd_en && !o_rd_empty) begin
            r_cnt <= r_cnt;
        end
        else if (i_wr_en && !o_wr_full) begin
            r_cnt <= r_cnt + 1'b1;
        end
        else if (i_rd_en && !o_rd_empty) begin
            r_cnt <= r_cnt - 1'b1;
        end
        else begin
            r_cnt <= r_cnt;
        end
    end

    // Write operations
    reg_rst_y_mode_a_en_y #(
        .DATA_WIDTH(PTRS_WIDTH)
    ) u_reg_wr_ptr(
        .i_clk  (i_clk),
        .i_rst_n(i_rst_n),
        .i_en   (i_wr_en && !o_wr_full),
        .i_data (r_wr_ptr + 1'b1),
        .o_data (r_wr_ptr)
    );

    integer i;
    always_ff @(posedge i_clk or negedge i_rst_n) begin
        if (!i_rst_n) begin
            for (i = 0; i < FIFO_DEPTH; i++) begin
                r_sram[i] <= {DATA_WIDTH{1'b0}};
            end
        end
        else if (i_wr_en && !o_wr_full) begin
            r_sram[r_wr_ptr] <= i_wr_data;
        end
        else begin
            r_sram[r_wr_ptr] <= r_sram[r_wr_ptr];
        end
    end

    assign o_wr_full = (r_cnt === FIFO_DEPTH) ? 1'b1 : 1'b0;

    // Read operations
    reg_rst_y_mode_a_en_y #(
        .DATA_WIDTH(PTRS_WIDTH)
    ) u_reg_rd_ptr(
        .i_clk  (i_clk),
        .i_rst_n(i_rst_n),
        .i_en   (i_rd_en && !o_rd_empty),
        .i_data (r_rd_ptr + 1'b1),
        .o_data (r_rd_ptr)
    );

    reg_rst_y_mode_a_en_y #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u_reg_rd_data(
        .i_clk  (i_clk),
        .i_rst_n(i_rst_n),
        .i_en   (i_rd_en && !o_rd_empty),
        .i_data (r_sram[r_rd_ptr]),
        .o_data (o_rd_data)
    );

    assign o_rd_empty = (r_cnt === 0) ? 1'b1 : 1'b0;

endmodule
