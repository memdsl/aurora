/*
 * @Author      : myyerrol
 * @Date        : 2024-11-02 18:09:48
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-11-07 15:35:29
 * @Description : Tools testbench.
 *
 * Copyright (c) 2024 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

module fifo_tb();

initial begin
    $dumpfile("build/fifo.vcd");
    $dumpvars(0, fifo_tb);
end

parameter DATA_WIDTH = 16;

logic                      w_rst_n;
logic                      w_wr_clk;
logic                      w_wr_en;
logic [DATA_WIDTH - 1 : 0] w_wr_data;
logic                      w_rd_clk;
logic                      w_rd_en;

// Cycle =  3ns, Freq = 300MHz
always #1.5 w_wr_clk  = ~w_wr_clk;
// Cycle =  2ns, Freq = 200MHz
always #1   w_rd_clk  = ~w_rd_clk;
always #3   w_wr_data = {$random} % {DATA_WIDTH{1'b1}};

initial begin
    w_rst_n  = 1'b1;

    w_wr_clk = 1'b0;
    w_wr_en  = 1'b0;
    w_wr_data= {DATA_WIDTH{1'b0}};

    w_rd_clk = 1'b0;
    w_rd_en  = 1'b0;

    # 1 w_rst_n = 0;
    # 2 w_rst_n = 1;



    #20 w_wr_en = 1'b1;
        w_rd_en = 1'b0;
    #40 w_wr_en = 1'b0;
        w_rd_en = 1'b1;
    #30 w_wr_en = 1'b1;
        w_rd_en = 1'b0;
    #13 w_rd_en = 1'b1;
    #10

    repeat(100)
    begin
    #5 w_wr_en = {$random}%2 ;
        w_rd_en = {$random}%2 ;
    end

    #1000 $finish;
end

fifo_mode_a #(
    .DATA_WIDTH(DATA_WIDTH),
    .FIFO_DEPTH(8)
) u_async_fifo(
    .i_wr_clk  (w_wr_clk),
    .i_wr_rst_n(w_rst_n),
    .i_wr_en   (w_wr_en),
    .i_wr_data (w_wr_data),
    .o_wr_full (),

    .i_rd_clk  (w_rd_clk),
    .i_rd_rst_n(w_rst_n),
    .i_rd_en   (w_rd_en),
    .o_rd_data (),
    .o_rd_empty()
);

endmodule
