/*
 * @Author      : myyerrol
 * @Date        : 2024-09-08 04:02:30
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-09-09 09:42:36
 * @FilePath    : /memdsl/aurora/src/interface/sram/tb/sram_axi4_tb.sv
 * @Description : SRAM with AXI4 slave interface testbench.
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`timescale 1ns / 1ps

module sram_axi4_tb();

initial begin
    $dumpfile("build/sram_axi4.vcd");
    $dumpvars(0, sram_axi4_tb);
end

parameter CYCLE = 10;

logic          w_rw_type;

logic          w_aclk;
logic          w_areset_n;

logic [ 7 : 0] w_araddr;
logic          w_arvalid;
logic          w_arready;

logic          w_rready;
logic          w_rlast;

logic [ 7 : 0] w_awaddr;
logic          w_awvalid;
logic          w_awready;

logic [63 : 0] w_wdata;
logic [ 7 : 0] w_wstrb;
// logic          w_wlast;
logic          w_wvalid;
logic          w_wready;

logic          w_bready;
logic          w_bvalid;

always #(CYCLE / 2) w_aclk = ~w_aclk;

initial begin
    w_rw_type  = 1'b1;

    w_aclk     = 1'b0;
    w_areset_n = 1'b0;
    w_rready   = 1'b1;
    #(CYCLE * 1);
    w_areset_n = 1'b1;
    #(CYCLE * 5);
    w_rw_type  = 1'b0;
    #(CYCLE * 100);
    $finish;
end

sram_axi4_m u_sram_axi4_m(
    .i_rw_type (w_rw_type),
    .i_aclk    (w_aclk),
    .i_areset_n(w_areset_n),
    .i_arready (w_arready),
    .o_araddr  (w_araddr),
    .o_arvalid (w_arvalid),
    .i_rlast   (w_rlast),
    .i_awready (w_awready),
    .o_awaddr  (w_awaddr),
    .o_awvalid (w_awvalid),
    .i_wready  (w_wready),
    .o_wdata   (w_wdata),
    .o_wstrb   (w_wstrb),
    .o_wvalid  (w_wvalid),
    .i_bvalid  (w_bvalid),
    .o_bready  (w_bready)
);

sram_axi4 u_sram_axi4(
    .i_aclk    (w_aclk),
    .i_areset_n(w_areset_n),
    .i_arid    (4'd1),
    .i_araddr  (w_araddr),
    .i_arlen   (8'd1),
    .i_arsize  (3'd0),
    .i_arburst (2'b00),
    .i_arlock  (2'd0),
    .i_arcache (4'd0),
    .i_arprot  (3'd0),
    .i_arqos   (4'd0),
    .i_arregion(4'd0),
    .i_aruser  (4'd0),
    .i_arvalid (w_arvalid),
    .o_arready (w_arready),
    .i_rready  (w_rready),
    .o_rid     (),
    .o_rdata   (),
    .o_rresp   (),
    .o_rlast   (w_rlast),
    .o_ruser   (),
    .o_rvalid  (),
    .i_awid    (4'd1),
    .i_awaddr  (w_awaddr),
    .i_awlen   (8'd1),
    .i_awsize  (3'd0),
    .i_awburst (2'd0),
    .i_awlock  (2'd0),
    .i_awcache (4'd0),
    .i_awprot  (3'd0),
    .i_awqos   (4'd0),
    .i_awregion(4'd0),
    .i_awuser  (4'd0),
    .i_awvalid (w_awvalid),
    .o_awready (w_awready),
    .i_wid     (4'd1),
    .i_wdata   (w_wdata),
    .i_wstrb   (w_wstrb),
    .i_wlast   (),
    .i_wuser   (4'd0),
    .i_wvalid  (w_wvalid),
    .o_wready  (w_wready),
    .i_bready  (w_bready),
    .o_bid     (),
    .o_bresp   (),
    .o_buser   (),
    .o_bvalid  (w_bvalid)
);

endmodule
