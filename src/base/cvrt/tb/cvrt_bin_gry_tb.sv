/*
 * @Author      : myyerrol
 * @Date        : 2024-11-02 18:10:19
 * @LastEditors : myyerrol
 * @LastEditTime: 2025-02-02 19:55:37
 * @Description : Testbench.
 *
 * Copyright (c) 2024 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

module cvrt_bin_gry_tb();

initial begin
    $dumpfile("build/cvrt_bin_gry_tb.vcd");
    $dumpvars(0, cvrt_bin_gry_tb);
end

parameter DATA_WIDTH = 4;

logic [DATA_WIDTH - 1 : 0] w_bin;
logic [DATA_WIDTH - 1 : 0] w_gry;

initial begin
        w_bin = 4'b0000;
    #10 w_bin = 4'b0001;
    #10 w_bin = 4'b0010;
    #10 w_bin = 4'b0011;
    #10 w_bin = 4'b0100;
    #10 w_bin = 4'b0101;
    #10 w_bin = 4'b0110;
    #10 w_bin = 4'b0111;
    #10 w_bin = 4'b1000;
    #10 w_bin = 4'b1001;
    #10 w_bin = 4'b1010;
    #10 w_bin = 4'b1011;
    #10 w_bin = 4'b1100;
    #10 w_bin = 4'b1101;
    #10 w_bin = 4'b1110;
    #10 w_bin = 4'b1111;
    #10 $finish;
end

cvrt_bin_gry #(
    .DATA_WIDTH(DATA_WIDTH)
) u_cvrt_bin_gry(
    .i_bin(w_bin),
    .o_gry(w_gry)
);

endmodule
