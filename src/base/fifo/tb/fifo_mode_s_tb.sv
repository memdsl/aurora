/*
 * @Author      : myyerrol
 * @Date        : 2024-11-02 18:09:48
 * @LastEditors : myyerrol
 * @LastEditTime: 2025-02-03 14:22:57
 * @Description : Testbench.
 *
 * Copyright (c) 2024 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

// verilator lint_off WIDTHTRUNC
module fifo_mode_s_tb();

initial begin
    $dumpfile("build/fifo_mode_s_tb.vcd");
    $dumpvars(0, fifo_mode_s_tb);
end

parameter DATA_WIDTH = 16;

logic                      r_clk_s;
logic                      r_rst_n_s;
logic                      r_wr_en_s;
logic [DATA_WIDTH - 1 : 0] r_wr_data_s;
logic                      r_rd_en_s;

// Cycle = 1ns Freq = 1000MHz
always #0.5 r_clk_s     = ~r_clk_s;
// Cycle = 2ns Freq =  500MHz

always #1   r_wr_data_s = $random % 10;

initial begin
    r_rst_n_s = 1'b1;
    r_clk_s   = 1'b0;

    r_wr_en_s   = 1'b0;
    r_wr_data_s = {DATA_WIDTH{1'b0}};

    #10 r_rst_n_s = 1'b0;
    #10 r_rst_n_s = 1'b1;

    #10 r_wr_en_s = 1'b1;
        r_rd_en_s = 1'b0;
    #10 r_wr_en_s = 1'b0;
        r_rd_en_s = 1'b1;
    #10 r_wr_en_s = 1'b1;
        r_rd_en_s = 1'b0;
    # 5 r_wr_en_s = 1'b1;
        r_rd_en_s = 1'b1;
    #10

    repeat(100) begin
        #5 r_wr_en_s = $random % 2;
           r_rd_en_s = $random % 2;
    end

    #100 $finish;
end

fifo_mode_s #(
    .DATA_WIDTH(DATA_WIDTH),
    .FIFO_DEPTH(8)
) u_fifo_s(
    .i_clk     (r_clk_s),
    .i_rst_n   (r_rst_n_s),

    .i_wr_en   (r_wr_en_s),
    .i_wr_data (r_wr_data_s),
    .o_wr_full (),

    .i_rd_en   (r_rd_en_s),
    .o_rd_data (),
    .o_rd_empty()
);

endmodule
