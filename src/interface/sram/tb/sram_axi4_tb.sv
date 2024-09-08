/*
 * @Author      : myyerrol
 * @Date        : 2024-09-08 04:02:30
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-09-08 18:20:57
 * @FilePath    : /memdsl/aurora/src/interface/sram/tb/sram_axi4_tb.sv
 * @Description : SRAM with AXI4 slave interface testbench.
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`timescale 1ns / 1ps

module sram_axi_tb();

initial begin
    $dumpfile("build/sram_axi4.vcd");
    $dumpvars(0, sram_axi4_tb);
end

parameter CYCLE = 10;

logic w_clk;
logic w_rst_n;

always #(CYCLE / 2) w_clk = ~w_clk;

initial begin

end

sram_axi4 u_sram_axi4(
    input  logic          i_aclk,
    input  logic          i_areset_n,
    input  logic [ 3 : 0] i_arid,
    input  logic [ 7 : 0] i_araddr,
    input  logic [ 7 : 0] i_arlen,
    input  logic [ 2 : 0] i_arsize,
    input  logic [ 1 : 0] i_arburst,
    input  logic [ 1 : 0] i_arlock,
    input  logic [ 3 : 0] i_arcache,
    input  logic [ 2 : 0] i_arprot,
    input  logic [ 3 : 0] i_arqos,
    input  logic [ 3 : 0] i_arregion,
    input  logic [ 3 : 0] i_aruser,
    input  logic          i_arvalid,
    output logic          o_arready,
    input  logic          i_rready,
    output logic [ 3 : 0] o_rid,
    output logic [63 : 0] o_rdata,
    output logic [ 1 : 0] o_rresp,
    output logic          o_rlast,
    output logic [ 3 : 0] o_ruser,
    output logic          o_rvalid,
    input  logic [ 3 : 0] i_awid,
    input  logic [ 7 : 0] i_awaddr,
    input  logic [ 7 : 0] i_awlen,
    input  logic [ 2 : 0] i_awsize,
    input  logic [ 1 : 0] i_awburst,
    input  logic [ 1 : 0] i_awlock,
    input  logic [ 3 : 0] i_awcache,
    input  logic [ 2 : 0] i_awprot,
    input  logic [ 3 : 0] i_awqos,
    input  logic [ 3 : 0] i_awregion,
    input  logic [ 3 : 0] i_awuser,
    input  logic          i_awvalid,
    output logic          o_awready,
    input  logic [ 3 : 0] i_wid,
    input  logic [63 : 0] i_wdata,
    input  logic [ 7 : 0] i_wstrb,
    input  logic          i_wlast,
    input  logic [ 3 : 0] i_wuser,
    input  logic          i_wvalid,
    output logic          o_wready,
    input  logic          i_bready,
    output logic [ 3 : 0] o_bid,
    output logic [ 1 : 0] o_bresp,
    output logic [ 3 : 0] o_buser,
    output logic          o_bvalid
)

endmodule