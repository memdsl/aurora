/*
 * @Author      : myyerrol
 * @Date        : 2024-09-05 14:17:09
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-09-09 19:02:19
 * @FilePath    : /memdsl/aurora/src/interface/sram/rtl/sram_axi4.sv
 * @Description : SRAM with AXI4 slave interface
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

module sram_axi4(
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
    // AXI4 I/O variables
    // ========================================================================
    // AXI4 read address
    logic [ 7 : 0] r_araddr;
    logic [ 7 : 0] r_arlen;
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
    // AXI4 temporary variables
    // ========================================================================
    logic [ 7 : 0] r_arlen_cnt;
    logic          w_arwrap_en;
    logic [ 7 : 0] w_arwrap_size;
    logic [ 7 : 0] r_arsize_byts;
    logic          w_arshake;

    logic          w_rshake;
    logic          w_rend;

    logic [ 7 : 0] r_awlen_cnt;
    logic          w_awwrap_en;
    logic [ 7 : 0] w_awwrap_size;
    logic [ 7 : 0] r_awsize_byts;
    logic          w_awshake;

    logic          w_wshake;
    logic          w_wend;

    logic          w_bshake;

    assign w_arwrap_en   = (r_araddr & w_arwrap_size) === w_arwrap_size ? 1'b1 : 1'b0;
    assign w_arwrap_size = (64 / 8 * r_arlen);
    assign w_arshake     = i_arvalid && r_arready;
    assign w_rshake      = r_rvalid  && i_rready;
    assign w_rend        = r_arlen_cnt === r_arlen;
    assign w_awwrap_en   = (r_awaddr & w_awwrap_size) === w_awwrap_size ? 1'b1 : 1'b0;
    assign w_awwrap_size = (64 / 8 * r_awlen);
    assign w_awshake     = i_awvalid && r_awready;
    assign w_wshake      = i_wvalid  && r_wready;
    assign w_wend        = r_awlen_cnt === r_awlen;
    assign w_bshake      = r_bvalid  && i_bready;

    // ========================================================================
    // Local parameters and variables
    // ========================================================================
    // 2KB
    logic [63 : 0] r_ram[255 : 0];

    // ========================================================================
    // AXI4 state machine
    // ========================================================================
    parameter S_IDLE    = 4'b0000;
    parameter S_RD_ADDR = 4'b0001;
    parameter S_RD_DATA = 4'b0011;
    parameter S_WR_ADDR = 4'b0010;
    parameter S_WR_DATA = 4'b0110;
    parameter S_WR_RESP = 4'b0111;

    logic [3 : 0] r_state_curr;
    logic [3 : 0] r_state_next;

    always_ff @(posedge i_aclk) begin
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
                else if (!w_arshake && w_awshake) begin
                    r_state_next = S_WR_ADDR;
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
            S_WR_ADDR: begin
                if (w_wshake) begin
                    r_state_next = S_WR_DATA;
                end
                else begin
                    r_state_next = S_WR_ADDR;
                end
            end
            S_WR_DATA: begin
                if (w_wend) begin
                    r_state_next = S_WR_RESP;
                end
                else begin
                    r_state_next = S_WR_DATA;
                end
            end
            S_WR_RESP: begin
                if (w_bshake) begin
                    r_state_next = S_IDLE;
                end
                else begin
                    r_state_next = S_WR_RESP;
                end
            end
            default: begin
                r_state_next = S_IDLE;
            end
        endcase
    end

    always_ff @(posedge i_aclk) begin
        if (!i_areset_n) begin
            r_araddr      <=  8'd0;
            r_arlen       <=  8'd0;
            r_arburst     <=  2'd0;
            r_arready     <=  1'b1;
            r_rdata       <= 64'd0;
            r_rresp       <=  2'b00;
            r_rlast       <=  1'b0;
            r_ruser       <=  4'd0;
            r_rvalid      <=  1'b0;

            r_arlen_cnt   <=  8'd0;
            r_arsize_byts <=  8'd0;
        end
        else begin
            case (r_state_curr)
                S_IDLE: begin
                    r_rlast       <=  1'b0;
                    r_arlen_cnt   <=  8'd0;
                    r_arsize_byts <=  8'd0;
                end
                S_RD_ADDR: begin
                    r_araddr      <= i_araddr[7 : 0];
                    r_arlen       <= i_arlen;
                    r_arburst     <= i_arburst;
                    r_rvalid      <= 1'b1;
                    r_arsize_byts <= (i_arsize === 3'b000) ?   8'd1 :
                                     (i_arsize === 3'b001) ?   8'd2 :
                                     (i_arsize === 3'b010) ?   8'd4 :
                                     (i_arsize === 3'b011) ?   8'd8 :
                                     (i_arsize === 3'b100) ?  8'd16 :
                                     (i_arsize === 3'b101) ?  8'd32 :
                                     (i_arsize === 3'b110) ?  8'd64 :
                                     (i_arsize === 3'b111) ? 8'd128 :
                                                               8'd1;
                end
                S_RD_DATA: begin
                    if (!w_rend) begin
                        case (r_arburst)
                            2'b00: begin
                                r_araddr <= r_araddr;
                            end
                            2'b01: begin
                                r_araddr <= r_araddr + r_arsize_byts;
                            end
                            2'b10: begin
                                if (w_arwrap_en) begin
                                    r_araddr <= r_araddr - w_arwrap_size;
                                end
                                else begin
                                    r_araddr <= r_araddr + r_arsize_byts;
                                end
                            end
                            default: begin
                                r_araddr <= r_araddr;
                            end
                        endcase
                        r_rlast     <= 1'b0;
                        r_rvalid    <= 1'b1;
                        r_arlen_cnt <= r_arlen_cnt + 1'b1;
                    end
                    else begin
                        r_rlast     <= 1'b1;
                        r_rvalid    <= 1'b0;
                        r_arlen_cnt <= r_arlen_cnt;
                    end

                    if (r_arlen_cnt >= 1) begin
                        r_rdata  <= r_ram[r_araddr];
                        r_rresp  <= 2'b00;
                    end
                end
                default: begin
                end
            endcase
        end
    end

    always_ff @(posedge i_aclk) begin
        if (!i_areset_n) begin
            r_awaddr      <=  8'd0;
            r_awlen       <=  8'd0;
            r_awburst     <=  2'd0;
            r_awready     <=  1'b1;
            r_wdata       <= 64'd0;
            r_wstrb       <=  8'd0;
            r_wlast       <=  1'b0;
            r_wready      <=  1'b1;
            r_bresp       <=  2'b00;
            r_buser       <=  4'd0;
            r_bvalid      <=  1'b0;

            r_awlen_cnt   <=  8'd0;
            r_awsize_byts <=  8'd0;
        end
        else begin
            case (r_state_curr)
                S_IDLE: begin
                    r_awlen_cnt   <= 8'd0;
                    r_awsize_byts <= 8'd0;
                end
                S_WR_ADDR: begin
                    r_awaddr      <= i_awaddr[7 : 0];
                    r_awlen       <= i_awlen;
                    r_awburst     <= i_awburst;
                    r_wdata       <= i_wdata;
                    r_wstrb       <= i_wstrb;
                    r_awsize_byts <= (i_awsize === 3'b000) ?   8'd1 :
                                     (i_awsize === 3'b001) ?   8'd2 :
                                     (i_awsize === 3'b010) ?   8'd4 :
                                     (i_awsize === 3'b011) ?   8'd8 :
                                     (i_awsize === 3'b100) ?  8'd16 :
                                     (i_awsize === 3'b101) ?  8'd32 :
                                     (i_awsize === 3'b110) ?  8'd64 :
                                     (i_awsize === 3'b111) ? 8'd128 :
                                                               8'd1;
                end
                S_WR_DATA: begin
                    if (!w_wend) begin
                        case (r_awburst)
                            2'b00: begin
                                r_awaddr <= r_awaddr;
                            end
                            2'b01: begin
                                r_awaddr <= r_awaddr + r_awsize_byts;
                            end
                            2'b10: begin
                                if (w_awwrap_en) begin
                                    r_awaddr <= r_awaddr - w_awwrap_size;
                                end
                                else begin
                                    r_awaddr <= r_awaddr + r_awsize_byts;
                                end
                            end
                            default: begin
                                r_awaddr <= r_awaddr;
                            end
                        endcase
                        r_wlast     <= 1'b0;
                        r_bvalid    <= 1'b0;
                        r_awlen_cnt <= r_awlen_cnt + 1'b1;
                    end
                    else begin
                        r_wlast     <= 1'b1;
                        r_bvalid    <= 1'b1;
                        r_awlen_cnt <= r_awlen_cnt;
                    end
                    r_wdata <= i_wdata;
                    r_wstrb <= i_wstrb;
                end
                S_WR_RESP: begin
                    r_wlast  <= 1'b0;
                    r_bresp  <= 2'b00;
                    r_bvalid <= 1'b0;
                end
                default: begin
                end
            endcase
        end
    end

    // ========================================================================
    // User RTL
    // ========================================================================
    always_ff @(posedge i_aclk) begin
        if (!i_areset_n) begin
            for (int i = 0; i < 256; i = i + 1) begin
                r_ram[i] <= {32'd0, i};
            end
        end
        else begin
            for (int i = 0; i < 64 / 8; i = i + 1) begin
                if ((r_awburst !== 2'b00 || r_awlen_cnt >= 1) &&
                    !r_wlast && r_wstrb[i]) begin
                    r_ram[r_awaddr][i * 8 + 7 -: 8] <= r_wdata[i * 8 + 7 -: 8];
                end
                else begin
                end
            end
        end
    end

endmodule
