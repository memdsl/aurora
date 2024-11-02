/*
 * @Author      : myyerrol
 * @Date        : 2024-11-02 18:10:12
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-11-02 18:59:29
 * @Description : Registers testbench.
 *
 * Copyright (c) 2024 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

module reg_tb();

initial begin
    $dumpfile("build/reg.vcd");
    $dumpvars(0, reg_tb);
end

parameter CYCLE      = 10;
parameter DATA_WIDTH = 32;

logic                      w_clk;
logic                      w_rst_n;
logic                      w_en;
logic [DATA_WIDTH - 1 : 0] w_data;

always #(CYCLE / 2) w_clk = ~w_clk;

initial begin
    w_clk   = 1'b0;

    w_rst_n = 1'b0;
    w_en    = 1'b0;
    w_data  = 32'hFFFF0000;
    #20;
    w_rst_n = 1'b1;
    w_en    = 1'b0;
    w_data  = 32'hFFFF00FF;
    #20;
    w_rst_n = 1'b1;
    w_en    = 1'b1;
    w_data  = 32'hFFFFFFFF;
    #20 $finish;
end

reg_rst_n_mode_n_en_n #(
    .DATA_WIDTH(DATA_WIDTH)
) u_reg_rst_n_mode_n_en_n(
    .i_clk (w_clk),
    .i_data(w_data),
    .o_data()
);

reg_rst_n_mode_n_en_y #(
    .DATA_WIDTH(DATA_WIDTH)
) u_reg_rst_n_mode_n_en_y(
    .i_clk (w_clk),
    .i_en  (w_en),
    .i_data(w_data),
    .o_data()
);

reg_rst_y_mode_s_en_n #(
    .DATA_WIDTH(DATA_WIDTH)
) u_reg_rst_y_mode_s_en_n(
    .i_clk  (w_clk),
    .i_rst_n(w_rst_n),
    .i_data (w_data),
    .o_data ()
);

reg_rst_y_mode_s_en_y #(
    .DATA_WIDTH(DATA_WIDTH)
) u_reg_rst_y_mode_s_en_y(
    .i_clk  (w_clk),
    .i_rst_n(w_rst_n),
    .i_en   (w_en),
    .i_data (w_data),
    .o_data ()
);

reg_rst_y_mode_a_en_n #(
    .DATA_WIDTH(DATA_WIDTH)
) u_reg_rst_y_mode_a_en_n(
    .i_clk  (w_clk),
    .i_rst_n(w_rst_n),
    .i_data (w_data),
    .o_data ()
);

reg_rst_y_mode_a_en_y #(
    .DATA_WIDTH(DATA_WIDTH)
) u_reg_rst_y_mode_a_en_y(
    .i_clk  (w_clk),
    .i_rst_n(w_rst_n),
    .i_en   (w_en),
    .i_data (w_data),
    .o_data ()
);

reg_lch #(
    .DATA_WIDTH(DATA_WIDTH)
) u_reg_lch(
    .i_en  (w_en),
    .i_data(w_data),
    .o_data()
);

endmodule
