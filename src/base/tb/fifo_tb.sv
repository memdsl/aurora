/*
 * @Author      : myyerrol
 * @Date        : 2024-11-02 18:09:48
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-12-19 18:31:42
 * @Description : Tools testbench.
 *
 * Copyright (c) 2024 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

// verilator lint_off WIDTHTRUNC
module fifo_tb();

initial begin
    $dumpfile("build/fifo_tb.vcd");
    $dumpvars(0, fifo_tb);
end

parameter DATA_WIDTH = 16;

// FIFO Synchronization
logic                      w_clk_s;
logic                      w_rst_n_s;
logic                      w_wr_en_s;
logic [DATA_WIDTH - 1 : 0] w_wr_data_s;
logic                      w_rd_en_s;

// Cycle = 1ns Freq = 1000MHz
always #0.5 w_clk_s     = ~w_clk_s;
// Cycle = 2ns Freq =  500MHz

always #1   w_wr_data_s = $random % 10;

initial begin
    w_rst_n_s = 1'b1;
    w_clk_s   = 1'b0;

    w_wr_en_s   = 1'b0;
    w_wr_data_s = {DATA_WIDTH{1'b0}};

    #10 w_rst_n_s = 1'b0;
    #10 w_rst_n_s = 1'b1;

    #10 w_wr_en_s = 1'b1;
        w_rd_en_s = 1'b0;
    #10 w_wr_en_s = 1'b0;
        w_rd_en_s = 1'b1;
    #10 w_wr_en_s = 1'b1;
        w_rd_en_s = 1'b0;
    # 5 w_wr_en_s = 1'b1;
        w_rd_en_s = 1'b1;
    #10

    repeat(100) begin
        #5 w_wr_en_s = $random % 2;
           w_rd_en_s = $random % 2;
    end

    #100 $finish;
end

fifo_mode_s #(
    .DATA_WIDTH(DATA_WIDTH),
    .FIFO_DEPTH(8)
) u_fifo_s(
    .i_clk     (w_clk_s),
    .i_rst_n   (w_rst_n_s),

    .i_wr_en   (w_wr_en_s),
    .i_wr_data (w_wr_data_s),
    .o_wr_full (),

    .i_rd_en   (w_rd_en_s),
    .o_rd_data (),
    .o_rd_empty()
);

// FIFO Asynchronization
logic                      w_rst_n_a;

logic                      w_wr_clk_a;
logic                      w_wr_en_a;
logic [DATA_WIDTH - 1 : 0] w_wr_data_a;
logic                      w_rd_clk_a;
logic                      w_rd_en_a;

// Cycle = 3ns, Freq = 333MHz
always #1.5 w_wr_clk_a  = ~w_wr_clk_a;
// Cycle = 2ns, Freq = 500MHz
always #1   w_rd_clk_a  = ~w_rd_clk_a;
// Cycle = 6ns, Freq = 166MHz
always #3   w_wr_data_a = $random;

initial begin
    w_rst_n_a  = 1'b1;

    w_wr_clk_a = 1'b0;
    w_wr_en_a  = 1'b0;
    w_wr_data_a= {DATA_WIDTH{1'b0}};

    w_rd_clk_a = 1'b0;
    w_rd_en_a  = 1'b0;

    #10 w_rst_n_a = 0;
    #10 w_rst_n_a = 1;

    #30 w_wr_en_a = 1'b1;
        w_rd_en_a = 1'b0;
    #30 w_wr_en_a = 1'b0;
        w_rd_en_a = 1'b1;
    #30 w_wr_en_a = 1'b1;
        w_rd_en_a = 1'b0;
    #30 w_rd_en_a = 1'b1;
    #30

    repeat (100) begin
        #5 w_wr_en_a = $random % 2;
           w_rd_en_a = $random % 2;
    end

    #100 $finish;
end

fifo_mode_a #(
    .DATA_WIDTH(DATA_WIDTH),
    .FIFO_DEPTH(8)
) u_fifo_a(
    .i_wr_clk  (w_wr_clk_a),
    .i_wr_rst_n(w_rst_n_a),
    .i_wr_en   (w_wr_en_a),
    .i_wr_data (w_wr_data_a),
    .o_wr_full (),

    .i_rd_clk  (w_rd_clk_a),
    .i_rd_rst_n(w_rst_n_a),
    .i_rd_en   (w_rd_en_a),
    .o_rd_data (),
    .o_rd_empty()
);

endmodule
