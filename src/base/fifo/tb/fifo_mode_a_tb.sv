/*
 * @Author      : myyerrol
 * @Date        : 2024-11-02 18:09:48
 * @LastEditors : myyerrol
 * @LastEditTime: 2025-02-03 14:22:45
 * @Description : Testbench.
 *
 * Copyright (c) 2024 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

// verilator lint_off WIDTHTRUNC
module fifo_mode_a_tb();

initial begin
    $dumpfile("build/fifo_mode_a_tb.vcd");
    $dumpvars(0, fifo_mode_a_tb);
end

parameter DATA_WIDTH = 16;

// FIFO Asynchronization
logic                      r_rst_n_a;

logic                      r_wr_clk_a;
logic                      r_wr_en_a;
logic [DATA_WIDTH - 1 : 0] r_wr_data_a;
logic                      r_rd_clk_a;
logic                      r_rd_en_a;

// Cycle = 3ns, Freq = 333MHz
always #1.5 r_wr_clk_a  = ~r_wr_clk_a;
// Cycle = 2ns, Freq = 500MHz
always #1   r_rd_clk_a  = ~r_rd_clk_a;
// Cycle = 6ns, Freq = 166MHz
always #3   r_wr_data_a = $random;

initial begin
    r_rst_n_a  = 1'b1;

    r_wr_clk_a = 1'b0;
    r_wr_en_a  = 1'b0;
    r_wr_data_a= {DATA_WIDTH{1'b0}};

    r_rd_clk_a = 1'b0;
    r_rd_en_a  = 1'b0;

    #10 r_rst_n_a = 0;
    #10 r_rst_n_a = 1;

    #30 r_wr_en_a = 1'b1;
        r_rd_en_a = 1'b0;
    #30 r_wr_en_a = 1'b0;
        r_rd_en_a = 1'b1;
    #30 r_wr_en_a = 1'b1;
        r_rd_en_a = 1'b0;
    #30 r_rd_en_a = 1'b1;
    #30

    repeat (100) begin
        #5 r_wr_en_a = $random % 2;
           r_rd_en_a = $random % 2;
    end

    #100 $finish;
end

fifo_mode_a #(
    .DATA_WIDTH(DATA_WIDTH),
    .FIFO_DEPTH(8)
) u_fifo_a(
    .i_wr_clk  (r_wr_clk_a),
    .i_wr_rst_n(r_rst_n_a),
    .i_wr_en   (r_wr_en_a),
    .i_wr_data (r_wr_data_a),
    .o_wr_full (),

    .i_rd_clk  (r_rd_clk_a),
    .i_rd_rst_n(r_rst_n_a),
    .i_rd_en   (r_rd_en_a),
    .o_rd_data (),
    .o_rd_empty()
);

endmodule
