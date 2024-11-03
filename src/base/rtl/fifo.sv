/*
 * @Author      : myyerrol
 * @Date        : 2024-11-02 15:22:27
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-11-08 11:12:53
 * @Description : First Input First Out
 *
 * Copyright (c) 2024 by MEMDSL, All Rights Reserved.
 */

`include "reg.sv"
`include "tool.sv"

interface fifo_io();
    // logic                      en;
    // logic [DATA_WIDTH - 1 : 0] data;

    // modport wr(
    //     input  rst_n,
    //     input  en,
    //     input  data,
    //     output full
    // );

    // modport rd(
    //     input  rst_n,
    //     input  en,
    //     output data,
    //     output empty
    // );
endinterface

// Async FIFO
module fifo_mode_a #(
    parameter DATA_WIDTH = 32,
    parameter FIFO_DEPTH =  8,
    parameter ADDR_WIDTH = $clog2(FIFO_DEPTH),
    parameter PTRS_WIDTH = ADDR_WIDTH + 1
) (
    input  logic                      i_wr_clk,
    input  logic                      i_wr_rst_n,
    input  logic                      i_wr_en,
    input  logic [DATA_WIDTH - 1 : 0] i_wr_data,
    output logic                      o_wr_full,

    input  logic                      i_rd_clk,
    input  logic                      i_rd_rst_n,
    input  logic                      i_rd_en,
    output logic [DATA_WIDTH - 1 : 0] o_rd_data,
    output logic                      o_rd_empty
);

    logic [DATA_WIDTH - 1 : 0] r_sram[FIFO_DEPTH - 1 : 0];

    logic [ADDR_WIDTH - 1 : 0] w_wr_addr;
    logic [ADDR_WIDTH - 1 : 0] w_rd_addr;

    logic [PTRS_WIDTH - 1 : 0] r_wr_ptr;
    logic [PTRS_WIDTH - 1 : 0] w_wr_ptr_gry;
    logic [PTRS_WIDTH - 1 : 0] r_wr_ptr_gry_d1;
    logic [PTRS_WIDTH - 1 : 0] r_wr_ptr_gry_d2;

    logic [PTRS_WIDTH - 1 : 0] r_rd_ptr;
    logic [PTRS_WIDTH - 1 : 0] w_rd_ptr_gry;
    logic [PTRS_WIDTH - 1 : 0] r_rd_ptr_gry_d1;
    logic [PTRS_WIDTH - 1 : 0] r_rd_ptr_gry_d2;

    // Write operations
    reg_rst_y_mode_a_en_y #(
        .DATA_WIDTH(PTRS_WIDTH)
    ) u_reg_wr_ptr(
        .i_clk  (i_wr_clk),
        .i_rst_n(i_wr_rst_n),
        .i_en   (i_wr_en && !o_wr_full),
        .i_data (r_wr_ptr + 1'b1),
        .o_data (r_wr_ptr)
    );

    tool_bin_2_gry #(
        .DATA_WIDTH(PTRS_WIDTH)
    ) u_tool_wr_ptr(
        .i_bin(r_wr_ptr),
        .o_gry(w_wr_ptr_gry)
    );

    reg_rst_y_mode_a_en_n #(
        .DATA_WIDTH(PTRS_WIDTH)
    ) u_reg_wr_ptr_gry_d1(
        .i_clk  (i_rd_clk),
        .i_rst_n(i_rd_rst_n),
        .i_data (w_wr_ptr_gry),
        .o_data (r_wr_ptr_gry_d1)
    );

    reg_rst_y_mode_a_en_n #(
        .DATA_WIDTH(PTRS_WIDTH)
    ) u_reg_wr_ptr_gry_d2(
        .i_clk  (i_rd_clk),
        .i_rst_n(i_rd_rst_n),
        .i_data (r_wr_ptr_gry_d1),
        .o_data (r_wr_ptr_gry_d2)
    );

    assign o_wr_full = (w_wr_ptr_gry == {~r_rd_ptr_gry_d2[PTRS_WIDTH - 1:
                                                          PTRS_WIDTH - 2],
                                          r_rd_ptr_gry_d2[PTRS_WIDTH - 3 : 0]})
                       ? 1'b1 : 1'b0;
    assign w_wr_addr = r_wr_ptr[PTRS_WIDTH - 2 : 0];

    integer i;
    always_ff @(posedge i_wr_clk or negedge i_wr_rst_n) begin
        if (!i_wr_rst_n) begin
            for (i = 0; i < FIFO_DEPTH; i++) begin
                r_sram[i] <= {DATA_WIDTH{1'b0}};
            end
        end
        else if (i_wr_en && !o_wr_full) begin
            r_sram[w_wr_addr] <= i_wr_data;
        end
        else begin
            r_sram[w_wr_addr] <= r_sram[w_wr_addr];
        end
    end

    // Read operations
    reg_rst_y_mode_a_en_y #(
        .DATA_WIDTH(PTRS_WIDTH)
    ) u_reg_rd_ptr(
        .i_clk  (i_rd_clk),
        .i_rst_n(i_rd_rst_n),
        .i_en   (i_rd_en && !o_rd_empty),
        .i_data (r_rd_ptr + 1'b1),
        .o_data (r_rd_ptr)
    );

    tool_bin_2_gry #(
        .DATA_WIDTH(PTRS_WIDTH)
    ) u_tool_rd_ptr(
        .i_bin(r_rd_ptr),
        .o_gry(w_rd_ptr_gry)
    );

    reg_rst_y_mode_a_en_n #(
        .DATA_WIDTH(PTRS_WIDTH)
    ) u_reg_rd_ptr_gry_d1(
        .i_clk  (i_wr_clk),
        .i_rst_n(i_wr_rst_n),
        .i_data (w_rd_ptr_gry),
        .o_data (r_rd_ptr_gry_d1)
    );

    reg_rst_y_mode_a_en_n #(
        .DATA_WIDTH(PTRS_WIDTH)
    ) u_reg_rd_ptr_gry_d2(
        .i_clk  (i_wr_clk),
        .i_rst_n(i_wr_rst_n),
        .i_data (r_rd_ptr_gry_d1),
        .o_data (r_rd_ptr_gry_d2)
    );

    assign o_rd_empty = (w_rd_ptr_gry == r_wr_ptr_gry_d2) ? 1'b1 : 1'b0;
    assign w_rd_addr  = r_rd_ptr[PTRS_WIDTH - 2 : 0];

    reg_rst_y_mode_a_en_y #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u_reg_rd_data(
        .i_clk  (i_rd_clk),
        .i_rst_n(i_rd_rst_n),
        .i_en   (i_rd_en && !o_rd_empty),
        .i_data (r_sram[w_rd_addr]),
        .o_data (o_rd_data)
    );
endmodule

// Sync FIFO
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
    logic [PTRS_WIDTH     : 0] w_cnt_nxt;

    logic w_wr_full;
    logic w_rd_empty;

    // Counter
    always_ff @(posedge i_clk or negedge i_rst_n) begin
        if (!i_rst_n) begin
            r_cnt <= {(PTRS_WIDTH + 1){1'b0}};
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

endmodule
