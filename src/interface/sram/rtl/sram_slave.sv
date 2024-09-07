/*
 * @Author      : myyerrol
 * @Date        : 2024-09-05 14:17:09
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-09-08 18:13:47
 * @FilePath    : /memdsl/aurora/src/interface/sram/rtl/sram_slave.sv
 * @Description : SRAM with AXI4 slave interface
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

module sram_slave(
    // AXI4 clock
    input  logic          i_aclk,
    input  logic          i_areset_n,
    // AXI4 read address
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
    // AXI4 read data
    input  logic          i_rready,
    output logic [ 3 : 0] o_rid,
    output logic [63 : 0] o_rdata,
    output logic [ 1 : 0] o_rresp,
    output logic          o_rlast,
    output logic [ 3 : 0] o_ruser,
    output logic          o_rvalid,
    // AXI4 write address
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
    // AXI4 write data
    input  logic [ 3 : 0] i_wid,
    input  logic [63 : 0] i_wdata,
    input  logic [ 7 : 0] i_wstrb,
    input  logic          i_wlast,
    input  logic [ 3 : 0] i_wuser,
    input  logic          i_wvalid,
    output logic          o_wready,
    // AXI4 write response
    input  logic          i_bready,
    output logic [ 3 : 0] o_bid,
    output logic [ 1 : 0] o_bresp,
    output logic [ 3 : 0] o_buser,
    output logic          o_bvalid
);

    // ========================================================================
    //
    // ========================================================================
    // AXI4 read address
    logic [ 7 : 0] r_araddr;
    logic [ 7 : 0] r_arlen;
    logic [ 2 : 0] r_arsize;
    logic [ 1 : 0] r_arburst;
    logic          r_arready;

    // AXI4 read data
    logic [63 : 0] r_rdata;
    logic [ 1 : 0] r_rresp;
    logic          r_rlast;
    logic [ 3 : 0] r_ruser;
    logic          r_rvalid;

    // AXI4 write address
    logic [ 7 : 0] r_awaddr;
    logic [ 7 : 0] r_awlen;
    logic [ 2 : 0] r_awsize;
    logic [ 1 : 0] r_awburst;
    logic          r_awready;

    // AXI4 write data
    logic [63 : 0] r_wdata;
    logic [ 7 : 0] r_wstrb;
    logic          r_wlast;
    logic          r_wready;

    // AXI4 write response
    logic [ 1 : 0] r_bresp;
    logic [ 3 : 0] r_buser;
    logic          r_bvalid;

    assign o_arready = r_arready;
    assign o_rid     = i_arid;
    assign o_rdata   = r_rdata;
    assign o_rresp   = r_rresp;
    assign o_rlast   = r_rlast;
    assign o_ruser   = r_ruser;
    assign o_rvalid  = r_rvalid;
    assign o_awready = r_awready;
    assign o_wready  = r_wready;
    assign o_bid     = i_awid;
    assign o_bresp   = r_bresp;
    assign o_buser   = r_buser;
    assign o_bvalid  = r_bvalid;

    // ========================================================================
    //
    // ========================================================================
    logic [ 7 : 0] r_arlen_cnt;
    logic          w_arwrap_en;
    logic [ 7 : 0] w_arwrap_size;
    logic          w_arshake;

    logic          w_rshake;
    logic          w_rend;

    logic [ 7 : 0] r_awlen_cnt;
    logic          w_awwrap_en;
    logic [ 7 : 0] w_awwrap_size;
    logic          w_awshake;

    logic          w_wshake;

    logic          w_bshake;

    assign w_arwrap_en   = (r_araddr & w_arwrap_size) === w_arwrap_size ? 1'b1 : 1'b0;
    assign w_arwrap_size = (64 / 8 * r_arlen);
    assign w_arshake     = i_arvalid && r_arready;
    assign w_rshake      = r_rvalid  && i_rready;
    assign w_rend        = r_rvalid  && i_rready && r_arlen_cnt === r_arlen;
    assign w_awwrap_en   = (r_awaddr & w_awwrap_size) === w_awwrap_size ? 1'b1 : 1'b0;
    assign w_awwrap_size = (64 / 8 * r_awlen);
    assign w_awshake     = i_awvalid && r_awready;
    assign w_wshake      = i_wvalid  && r_wready;
    assign w_bshake      = r_bvalid  && i_bready;

    // ========================================================================
    //
    // ========================================================================
    localparam integer ADDR_LSB = (64 / 32)+ 1;

    // 2KB
    logic [63 : 0] r_ram[255 : 0];

    // ========================================================================
    //
    // ========================================================================

    parameter S_IDLE    = 4'b0000;
    parameter S_RD_ADDR = 4'b0001;
    parameter S_RD_DATA = 4'b0010;

    logic [3 : 0] r_state_curr;
    logic [3 : 0] r_state_next;

    always_ff @(i_aclk) begin
        if (!i_areset_n) begin
            r_state_curr <= S_IDLE;
        end
        else begin
            r_state_curr <= r_state_next;
        end
    end

    always_comb begin
        case (r_state_curr)
            S_IDLE: begin
                if (w_arshake) begin
                    r_state_next = S_RD_ADDR;
                end
                else begin
                    r_state_next = S_IDLE;
                end
            end
            S_RD_ADDR: begin
                if (w_rshake) begin
                    r_state_next = S_RD_DATA;
                end
                else begin
                    r_state_next = S_RD_ADDR;
                end
            end
            S_RD_DATA: begin
                if (w_rend) begin
                    r_state_next = S_IDLE;
                end
                else begin
                    r_state_next = S_RD_DATA;
                end
            end
            default: begin
                r_state_next = S_IDLE;
            end
        endcase
    end

    always_ff @(i_aclk) begin
        if (!i_areset_n) begin
            r_araddr    <=  8'd0;
            r_arlen     <=  8'd0;
            r_arsize    <=  3'd0;
            r_arburst   <=  2'd0;
            r_arready   <=  1'b1;
            r_rdata     <= 64'd0;
            r_rresp     <= 2'b00;
            r_rlast     <=  1'b0;
            r_ruser     <=  4'd0;
            r_rvalid    <=  1'b0;

            r_arlen_cnt <=  8'd0;
        end
        else begin
            case (r_state_curr)
                S_IDLE: begin
                    r_araddr    <=  8'd0;
                    r_arlen     <=  8'd0;
                    r_arsize    <=  3'd0;
                    r_arburst   <=  2'd0;
                    r_arready   <=  1'b1;
                    r_rdata     <= 64'd0;
                    r_rresp     <= 2'b00;
                    r_rlast     <=  1'b0;
                    r_ruser     <=  4'd0;
                    r_rvalid    <=  1'b0;

                    r_arlen_cnt <=  8'd0;
                end
                S_RD_ADDR: begin
                    r_araddr  <= i_araddr[7 : 0];
                    r_arlen   <= i_arlen;
                    r_arsize  <= i_arsize;
                    r_arburst <= i_arburst;
                    r_rvalid  <= 1'b1;
                end
                S_RD_DATA: begin
                    if (!w_rend) begin
                        case (r_arburst)
                            2'b00: begin
                                r_araddr <= r_araddr;
                            end
                            2'b01: begin
                                r_araddr[7 : ADDR_LSB]     <= r_araddr[7 : ADDR_LSB] + 1'b1;
                                r_araddr[ADDR_LSB - 1 : 0] <= {ADDR_LSB{1'b0}};
                            end
                            2'b10: begin
                                if (w_arwrap_en) begin
                                    r_araddr <= r_araddr - w_arwrap_size;
                                end
                                else begin
                                    r_araddr[7 : ADDR_LSB]     <= r_araddr[7 : ADDR_LSB] + 1'b1;
                                    r_araddr[ADDR_LSB - 1 : 0] <= {ADDR_LSB{1'b0}};
                                end
                            end
                            default: begin
                                r_araddr <= r_araddr;
                            end
                        endcase
                        r_rlast     <= 1'b0;
                        r_arlen_cnt <= r_arlen_cnt + 1'b1;
                    end
                    else begin
                        r_rlast     <= 1'b1;
                        r_arlen_cnt <= r_arlen_cnt;
                    end
                    r_rdata  <= r_ram[r_araddr];
                    r_rvalid <= 1'b0;
                end
                default: begin
                    r_araddr  <= r_araddr;
                    r_arlen   <= r_arlen;
                    r_arsize  <= r_arsize;
                    r_arburst <= r_arburst;
                    r_arready <= r_arready;
                    r_rdata   <= r_rdata;
                    r_rresp   <= r_rresp;
                    r_rlast   <= r_rlast;
                    r_ruser   <= r_ruser;
                    r_rvalid  <= r_rvalid;
                end
            endcase
        end
    end

endmodule
