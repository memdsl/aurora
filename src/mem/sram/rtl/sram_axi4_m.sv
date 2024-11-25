/*
 * @Author      : myyerrol
 * @Date        : 2024-09-08 20:06:49
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-12-10 15:01:58
 * @Description : SRAM with AXI4 master interface.
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

module sram_axi4_m(
    input  logic          i_rw_type,

    input  logic          i_aclk,
    input  logic          i_areset_n,

    input  logic          i_arready,
    output logic [ 7 : 0] o_araddr,
    output logic          o_arvalid,

    input  logic          i_rlast,

    input  logic          i_awready,
    output logic [ 7 : 0] o_awaddr,
    output logic          o_awvalid,

    input  logic          i_wready,
    output logic [63 : 0] o_wdata,
    output logic [ 7 : 0] o_wstrb,
    output logic          o_wvalid,

    input  logic          i_bvalid,
    output logic          o_bready
);

    logic [ 7 : 0] r_araddr;
    logic          r_arvalid;
    logic          r_arshake;

    logic [ 7 : 0] r_awaddr;
    logic          r_awvalid;
    logic          r_awshake;

    logic [63 : 0] r_wdata;
    logic [ 7 : 0] r_wstrb;
    logic          r_wlast;
    logic          r_wvalid;

    logic          r_bshake;

    assign o_araddr  = r_araddr;
    assign o_arvalid = r_arvalid;

    assign o_awaddr  = r_awaddr;
    assign o_awvalid = r_awvalid;

    assign o_wdata   = r_wdata;
    assign o_wstrb   = r_wstrb;
    assign o_wvalid  = r_wvalid;

    assign o_bready  = 1'b1;

    always_ff @(posedge i_aclk) begin
        if (!i_areset_n) begin
            r_araddr  <= 8'd8;
            r_arvalid <= 1'b0;
            r_arshake <= 1'b0;
        end
        else begin
            // Run read transaction
            if (!r_arvalid && !i_rw_type && !r_arshake && r_bshake) begin
                r_araddr  <= r_araddr;
                r_arvalid <= 1'b1;
                r_arshake <= r_arshake;
            end
            // Run Write transaction
            else if (r_arvalid && i_rw_type && !r_arshake) begin
                r_araddr  <= r_araddr;
                r_arvalid <= 1'b0;
                r_arshake <= r_arshake;
            end
            else if (r_arvalid && i_arready) begin
                r_araddr  <= r_araddr;
                r_arvalid <= 1'b0;
                r_arshake <= 1'b1;
            end
            else if (i_rlast) begin
                r_araddr  <= r_araddr + 8'd8;
                r_arvalid <= 1'b1;
                r_arshake <= 1'b0;
            end
            else begin
                r_araddr  <= r_araddr;
                r_arvalid <= r_arvalid;
                r_arshake <= r_arshake;
            end
        end
    end

    always_ff @(posedge i_aclk) begin
        if (!i_areset_n) begin
            r_awaddr  <= 8'd8;
            r_awvalid <= 1'b0;
            r_wdata   <= 64'd1;
            r_wstrb   <= 8'b1111_1111;
            r_wvalid  <= 1'b0;
            r_awshake <= 1'b0;
            r_bshake  <= 1'b0;
        end
        else begin
            // Run Write transaction
            if (!r_awvalid && i_rw_type && !r_awshake) begin
                r_awaddr  <= r_awaddr;
                r_awvalid <= 1'b1;
                r_wdata   <= r_wdata;
                r_wstrb   <= r_wstrb;
                r_wvalid  <= r_wvalid;
                r_awshake <= r_awshake;
                r_bshake  <= 1'b0;
            end
            // Run read transaction (if write transcatio is not currently in
            // IDLE state, write the current data first before execute read
            // transaction.
            else if (r_awvalid && !i_rw_type && !r_awshake) begin
                r_awaddr  <= r_awaddr;
                r_awvalid <= 1'b0;
                r_wdata   <= r_wdata;
                r_wstrb   <= r_wstrb;
                r_wvalid  <= 1'b1;
                r_awshake <= 1'b1;
                r_bshake  <= r_bshake;
            end
            else if (r_awvalid && i_awready) begin
                r_awaddr  <= r_awaddr;
                r_awvalid <= 1'b0;
                r_wdata   <= r_wdata;
                r_wstrb   <= r_wstrb;
                r_wvalid  <= 1'b1;
                r_awshake <= 1'b1;
                r_bshake  <= r_bshake;
            end
            else if (r_wvalid && i_wready) begin
                r_awaddr  <= r_awaddr;
                r_awvalid <= r_awvalid;
                r_wdata   <= r_wdata;
                r_wstrb   <= r_wstrb;
                r_wvalid  <= 1'b0;
                r_awshake <= r_awshake;
                r_bshake  <= r_bshake;
            end
            else if (i_bvalid && o_bready) begin
                r_awaddr  <= r_awaddr + 8'd8;
                r_wdata   <= r_wdata + 64'd1;
                r_wstrb   <= r_wstrb;
                r_wvalid  <= r_wvalid;
                r_awshake <= 1'b0;
                r_bshake  <= 1'b1;
            end
            else begin
                r_awaddr  <= r_awaddr;
                r_awvalid <= r_awvalid;
                r_wdata   <= r_wdata;
                r_wstrb   <= r_wstrb;
                r_wvalid  <= r_wvalid;
                r_awshake <= r_awshake;
                r_bshake  <= r_bshake;
            end
        end
    end

endmodule
