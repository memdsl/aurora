/*
 * @Author      : myyerrol
 * @Date        : 2024-07-05 08:43:24
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-07-07 15:57:37
 * @FilePath    : /memdsl/aurora/src/sv/common/mul/rtl/mul_16bit_wallace.sv
 * @Description : xxbit wallace tree multiplier
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`include "mul_xxbit_booth.sv"

module mul_16bit_wallace(
    input  logic          i_clk,
    input  logic          i_rst_n,
    input  logic [15 : 0] i_num_a,
    input  logic [15 : 0] i_num_b,
    output logic          o_end,
    output logic [31 : 0] o_res
);

    logic [31 : 0] r_num_a;

    // always_ff @(posedge i_clk) begin
    //     if (!i_rst_n) begin
    //         r_num_a <= {{16{i_num_a[15]}}, i_num_a};
    //     end
    //     else begin

    //     end
    // end

    mul_xxbit_booth #(
        .16(2)
    ) mul_xxbit_booth_inst_0(
        .i_clk(i_clk),
        .i_rst_n(i_rst_n),
        .i_num_a(i_num_a),
        .i_num_b(i_num_b[1 : 0]),
        .o_end(),
        .o_res()
    );
    mul_xxbit_booth #(
        .16(2)
    ) mul_xxbit_booth_inst_1(
        .i_clk(i_clk),
        .i_rst_n(i_rst_n),
        .i_num_a(i_num_a),
        .i_num_b(i_num_b[3 : 2]),
        .o_end(),
        .o_res()
    );
    mul_xxbit_booth #(
        .16(2)
    ) mul_xxbit_booth_inst_2(
        .i_clk(i_clk),
        .i_rst_n(i_rst_n),
        .i_num_a(r_num_a[5 : 4]),
        .i_num_b(i_num_b[5 : 4]),
        .o_end(),
        .o_res()
    );
    mul_xxbit_booth #(
        .16(2)
    ) mul_xxbit_booth_inst_3(
        .i_clk(i_clk),
        .i_rst_n(i_rst_n),
        .i_num_a(r_num_a[7 : 6]),
        .i_num_b(i_num_b[7 : 6]),
        .o_end(),
        .o_res()
    );
    mul_xxbit_booth #(
        .16(2)
    ) mul_xxbit_booth_inst_4(
        .i_clk(i_clk),
        .i_rst_n(i_rst_n),
        .i_num_a(r_num_a[9 : 8]),
        .i_num_b(i_num_b[9 : 8]),
        .o_end(),
        .o_res()
    );
    mul_xxbit_booth #(
        .16(2)
    ) mul_xxbit_booth_inst_5(
        .i_clk(i_clk),
        .i_rst_n(i_rst_n),
        .i_num_a(r_num_a[11 : 10]),
        .i_num_b(i_num_b[11 : 10]),
        .o_end(),
        .o_res()
    );
    mul_xxbit_booth #(
        .16(2)
    ) mul_xxbit_booth_inst_6(
        .i_clk(i_clk),
        .i_rst_n(i_rst_n),
        .i_num_a(r_num_a[13 : 12]),
        .i_num_b(i_num_b[13 : 12]),
        .o_end(),
        .o_res()
    );
    mul_xxbit_booth #(
        .16(2)
    ) mul_xxbit_booth_inst_7(
        .i_clk(i_clk),
        .i_rst_n(i_rst_n),
        .i_num_a(r_num_a[15 : 14]),
        .i_num_b(i_num_b[15 : 14]),
        .o_end(),
        .o_res()
    );

endmodule
