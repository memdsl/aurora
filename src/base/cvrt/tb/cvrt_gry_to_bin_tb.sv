/*
 * @Author      : myyerrol
 * @Date        : 2024-11-02 18:10:19
 * @LastEditors : myyerrol
 * @LastEditTime: 2025-02-08 09:45:25
 * @Description : Testbench.
 *
 * Copyright (c) 2024 by MEMDSL, All Rights Reserved.
 */

`timescale 1ns / 1ps

module cvrt_gry_to_bin_tb();

initial begin
    $dumpfile("build/cvrt_gry_to_bin_tb.vcd");
    $dumpvars(0, cvrt_gry_to_bin_tb);
end

parameter DATA_WIDTH = 4;

logic [DATA_WIDTH - 1 : 0] r_gry;

initial begin
        r_gry = 4'b0000;
    #10 r_gry = 4'b0001;
    #10 r_gry = 4'b0010;
    #10 r_gry = 4'b0011;
    #10 r_gry = 4'b0100;
    #10 r_gry = 4'b0101;
    #10 r_gry = 4'b0110;
    #10 r_gry = 4'b0111;
    #10 r_gry = 4'b1000;
    #10 r_gry = 4'b1001;
    #10 r_gry = 4'b1010;
    #10 r_gry = 4'b1011;
    #10 r_gry = 4'b1100;
    #10 r_gry = 4'b1101;
    #10 r_gry = 4'b1110;
    #10 r_gry = 4'b1111;
    #10 $finish;
end

cvrt_gry_to_bin #(
    .DATA_WIDTH(DATA_WIDTH)
) u_cvrt_to_gry_bin(
    .i_gry(r_gry),
    .o_bin()
);

endmodule
