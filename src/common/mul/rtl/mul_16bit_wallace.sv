/*
 * @Author      : myyerrol
 * @Date        : 2024-07-05 08:43:24
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-09-08 18:23:32
 * @FilePath    : /memdsl/aurora/src/common/mul/rtl/mul_16bit_wallace.sv
 * @Description : 16bit wallace tree multiplier
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`include "adder_nnbit_serial.sv"
`include "mul_01bitx08_wallace.sv"
`include "mul_02bit_booth.sv"

module mul_16bit_wallace(
    input  logic          i_clk,
    input  logic          i_rst_n,
    input  logic [15 : 0] i_num_x,
    input  logic [15 : 0] i_num_y,
    output logic          o_end,
    output logic [31 : 0] o_res,
    output logic          o_cry
);

    logic [31 : 0] w_num_x;
    logic [16 : 0] w_num_y;

    assign w_num_x = {{16{i_num_x[15]}}, i_num_x};
    assign w_num_y = {i_num_y, 1'b0};

    logic [31 : 0] r_booth_res[7 : 0];
    logic [ 7 : 0] r_booth_cry;

    logic [16 : 0] w_wallace_num_y[7 : 0];
    logic [31 : 0] w_booth_res[7 : 0];
    logic [ 7 : 0] w_booth_cry;

    always_ff @(posedge i_clk) begin
        if (!i_rst_n) begin
            r_booth_res[0] <= 32'h0000_0000;
            r_booth_res[1] <= 32'h0000_0000;
            r_booth_res[2] <= 32'h0000_0000;
            r_booth_res[3] <= 32'h0000_0000;
            r_booth_res[4] <= 32'h0000_0000;
            r_booth_res[5] <= 32'h0000_0000;
            r_booth_res[6] <= 32'h0000_0000;
            r_booth_res[7] <= 32'h0000_0000;
            r_booth_cry    <= 8'h0;
        end
        else begin
            r_booth_res[0] <= w_booth_res[0];
            r_booth_res[1] <= w_booth_res[1];
            r_booth_res[2] <= w_booth_res[2];
            r_booth_res[3] <= w_booth_res[3];
            r_booth_res[4] <= w_booth_res[4];
            r_booth_res[5] <= w_booth_res[5];
            r_booth_res[6] <= w_booth_res[6];
            r_booth_res[7] <= w_booth_res[7];
            r_booth_cry    <= w_booth_cry;
        end
    end

    generate
        genvar i;
        for (i = 0; i < 8; i = i + 1) begin: calc_booth
            assign w_wallace_num_y[i] = w_num_y >> (i * 2);
            mul_02bit_booth #(.DATA_WIDTH(16)) u_mul_02bit_booth(
                .i_num_x(w_num_x << (i * 2)),
                .i_num_y(w_wallace_num_y[i][2 : 0]),
                .o_res(w_booth_res[i]),
                .o_cry(w_booth_cry[i])
            );
        end
    endgenerate

    /* ===================================================================== */

    logic [7 : 0] w_switch_res[31 : 0];
    logic [7 : 0] w_switch_cry;

    generate
        genvar j;
        for (i = 0; i < 32; i = i + 1) begin: gen_wallace
            for (j = 0; j < 8; j = j + 1) begin
                assign w_switch_res[i][j] = r_booth_res[j][i];
            end
        end
    endgenerate

    assign w_switch_cry = r_booth_cry;

    /* ===================================================================== */

    logic [ 7 : 0] w_wallace_num[31 : 0];
    logic [31 : 0] w_wallace_res;
    logic [31 : 0] w_wallace_cry;
    logic [ 5 : 0] w_wallace_cry_06bit_i[31 : 0];
    logic [ 5 : 0] w_wallace_cry_06bit_o[31 : 0];

    assign w_wallace_cry_06bit_i[0] = w_switch_cry[5 : 0];

    generate
        for (i = 0; i < 32; i = i + 1) begin: calc_wallace
            assign w_wallace_num[i] = w_switch_res[i];
            mul_01bitx08_wallace u_mul_01bitx08_wallace(
                .i_num(w_wallace_num[i]),
                .i_cry_06bit(w_wallace_cry_06bit_i[i]),
                .o_cry_06bit(w_wallace_cry_06bit_o[i]),
                .o_res(w_wallace_res[i]),
                .o_cry(w_wallace_cry[i])
            );
            if (i != 31) begin
                assign w_wallace_cry_06bit_i[i + 1] = w_wallace_cry_06bit_o[i];
            end
        end
    endgenerate

    /* ===================================================================== */

    logic [31 : 0] r_adder_num_a;
    logic [31 : 0] r_adder_num_b;
    logic          r_adder_cry;

    always_ff @(posedge i_clk) begin
        if (!i_rst_n) begin
            r_adder_num_a <= 32'h0000_0000;
            r_adder_num_b <= 32'h0000_0000;
            r_adder_cry   <= 1'b0;
        end
        else begin
            r_adder_num_a <= (w_wallace_cry[30 : 0] << 1) | w_switch_cry[6];
            r_adder_num_b <= w_wallace_res;
            r_adder_cry   <= w_switch_cry[7];
        end
    end

    /* ===================================================================== */

    int count = 0;

    always_ff @(posedge i_clk) begin
        if (!i_rst_n) begin
            count <= 32'h0000_0000;
        end
        else begin
            if (count == 32'h3) begin
                count <= count;
            end
            else begin
                count <= count + 1'b1;
            end
        end
    end

    logic [31 : 0] w_adder_num_a;
    logic [31 : 0] w_adder_num_b;
    logic          w_adder_cry;

    assign w_adder_num_a = (count == 32'h3) ? r_adder_num_a : 32'h0000_0000;
    assign w_adder_num_b = (count == 32'h3) ? r_adder_num_b : 32'h0000_0000;
    assign w_adder_cry   = (count == 32'h3) ? r_adder_cry   : 1'b0;

    adder_nnbit_serial #(
        .DATA_WIDTH(32)
    ) u_adder_nnbit_serial(
        .i_num_a(w_adder_num_a),
        .i_num_b(w_adder_num_b),
        .i_cry(w_adder_cry),
        .o_res(o_res),
        .o_cry(o_cry)
    );

    assign o_end = (count == 32'h3) ? 1'b1 : 1'b0;
endmodule
