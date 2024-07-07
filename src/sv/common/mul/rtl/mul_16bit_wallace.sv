/*
 * @Author      : myyerrol
 * @Date        : 2024-07-05 08:43:24
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-07-07 22:03:22
 * @FilePath    : /memdsl/aurora/src/sv/common/mul/rtl/mul_16bit_wallace.sv
 * @Description : xxbit wallace tree multiplier
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`include "mul_01bitx08_wallace.sv"
`include "adder_xxbit_serial.sv"

module mul_16bit_wallace(
    input  logic          i_clk,
    input  logic          i_rst_n,
    input  logic [15 : 0] i_num_a,
    input  logic [15 : 0] i_num_b,
    output logic          o_end,
    output logic [31 : 0] o_res,
    output logic          o_cry
);

    logic [31 : 0] r_num_a;

    // always_ff @(posedge i_clk) begin
    //     if (!i_rst_n) begin
    //         r_num_a <= {{16{i_num_a[15]}}, i_num_a};
    //     end
    //     else begin

    //     end
    // end

    // mul_xxbit_booth #(
    //     .16(2)
    // ) mul_xxbit_booth_inst_0(
    //     .i_clk(i_clk),
    //     .i_rst_n(i_rst_n),
    //     .i_num_a(i_num_a),
    //     .i_num_b(i_num_b[1 : 0]),
    //     .o_end(),
    //     .o_res()
    // );
    // mul_xxbit_booth #(
    //     .16(2)
    // ) mul_xxbit_booth_inst_1(
    //     .i_clk(i_clk),
    //     .i_rst_n(i_rst_n),
    //     .i_num_a(i_num_a),
    //     .i_num_b(i_num_b[3 : 2]),
    //     .o_end(),
    //     .o_res()
    // );
    // mul_xxbit_booth #(
    //     .16(2)
    // ) mul_xxbit_booth_inst_2(
    //     .i_clk(i_clk),
    //     .i_rst_n(i_rst_n),
    //     .i_num_a(r_num_a[5 : 4]),
    //     .i_num_b(i_num_b[5 : 4]),
    //     .o_end(),
    //     .o_res()
    // );
    // mul_xxbit_booth #(
    //     .16(2)
    // ) mul_xxbit_booth_inst_3(
    //     .i_clk(i_clk),
    //     .i_rst_n(i_rst_n),
    //     .i_num_a(r_num_a[7 : 6]),
    //     .i_num_b(i_num_b[7 : 6]),
    //     .o_end(),
    //     .o_res()
    // );
    // mul_xxbit_booth #(
    //     .16(2)
    // ) mul_xxbit_booth_inst_4(
    //     .i_clk(i_clk),
    //     .i_rst_n(i_rst_n),
    //     .i_num_a(r_num_a[9 : 8]),
    //     .i_num_b(i_num_b[9 : 8]),
    //     .o_end(),
    //     .o_res()
    // );
    // mul_xxbit_booth #(
    //     .16(2)
    // ) mul_xxbit_booth_inst_5(
    //     .i_clk(i_clk),
    //     .i_rst_n(i_rst_n),
    //     .i_num_a(r_num_a[11 : 10]),
    //     .i_num_b(i_num_b[11 : 10]),
    //     .o_end(),
    //     .o_res()
    // );
    // mul_xxbit_booth #(
    //     .16(2)
    // ) mul_xxbit_booth_inst_6(
    //     .i_clk(i_clk),
    //     .i_rst_n(i_rst_n),
    //     .i_num_a(r_num_a[13 : 12]),
    //     .i_num_b(i_num_b[13 : 12]),
    //     .o_end(),
    //     .o_res()
    // );
    // mul_xxbit_booth #(
    //     .16(2)
    // ) mul_xxbit_booth_inst_7(
    //     .i_clk(i_clk),
    //     .i_rst_n(i_rst_n),
    //     .i_num_a(r_num_a[15 : 14]),
    //     .i_num_b(i_num_b[15 : 14]),
    //     .o_end(),
    //     .o_res()
    // );




    logic [7 : 0] w_switch_num[31 : 0];
    logic         w_switch_num_00;
    logic [5 : 0] w_switch_cry_00;
    logic [5 : 0] w_switch_cry_01;
    logic [5 : 0] w_switch_cry_02;
    logic [5 : 0] w_switch_cry_03;
    logic [5 : 0] w_switch_cry_04;
    logic [5 : 0] w_switch_cry_05;
    logic [5 : 0] w_switch_cry_06;
    logic [5 : 0] w_switch_cry_07;
    logic [5 : 0] w_switch_cry_08;
    logic [5 : 0] w_switch_cry_09;
    logic [5 : 0] w_switch_cry_10;
    logic [5 : 0] w_switch_cry_11;
    logic [5 : 0] w_switch_cry_12;
    logic [5 : 0] w_switch_cry_13;
    logic [5 : 0] w_switch_cry_14;
    logic [5 : 0] w_switch_cry_15;
    logic [5 : 0] w_switch_cry_16;
    logic [5 : 0] w_switch_cry_17;
    logic [5 : 0] w_switch_cry_18;
    logic [5 : 0] w_switch_cry_19;
    logic [5 : 0] w_switch_cry_20;
    logic [5 : 0] w_switch_cry_21;
    logic [5 : 0] w_switch_cry_22;
    logic [5 : 0] w_switch_cry_23;
    logic [5 : 0] w_switch_cry_24;
    logic [5 : 0] w_switch_cry_25;
    logic [5 : 0] w_switch_cry_26;
    logic [5 : 0] w_switch_cry_27;
    logic [5 : 0] w_switch_cry_28;
    logic [5 : 0] w_switch_cry_29;
    logic [5 : 0] w_switch_cry_30;
    logic [5 : 0] w_switch_cry_31;
    logic         w_switch_cry_imd;

    logic [31 : 0] w_adder_num_a;
    logic [31 : 0] w_adder_num_b;
    logic          w_adder_cry;

    assign w_adder_num_b[0] = w_switch_num_00;
    assign w_adder_cry      = w_switch_cry_imd;

    mul_01bitx08_wallace mul_01bitx08_wallace_inst_0(
        .i_num(w_switch_num[0]),
        .i_cry(w_switch_cry_00),
        .o_res(w_adder_num_a[0]),
        .o_cry(w_switch_cry_01),
        .o_cry_01bit(w_adder_num_b[1])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_1(
        .i_num(w_switch_num[1]),
        .i_cry(w_switch_cry_01),
        .o_res(w_adder_num_a[1]),
        .o_cry(w_switch_cry_02),
        .o_cry_01bit(w_adder_num_b[2])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_2(
        .i_num(w_switch_num[2]),
        .i_cry(w_switch_cry_02),
        .o_res(w_adder_num_a[2]),
        .o_cry(w_switch_cry_03),
        .o_cry_01bit(w_adder_num_b[3])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_3(
        .i_num(w_switch_num[3]),
        .i_cry(w_switch_cry_03),
        .o_res(w_adder_num_a[3]),
        .o_cry(w_switch_cry_04),
        .o_cry_01bit(w_adder_num_b[4])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_4(
        .i_num(w_switch_num[4]),
        .i_cry(w_switch_cry_04),
        .o_res(w_adder_num_a[4]),
        .o_cry(w_switch_cry_05),
        .o_cry_01bit(w_adder_num_b[5])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_5(
        .i_num(w_switch_num[5]),
        .i_cry(w_switch_cry_05),
        .o_res(w_adder_num_a[5]),
        .o_cry(w_switch_cry_06),
        .o_cry_01bit(w_adder_num_b[6])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_6(
        .i_num(w_switch_num[6]),
        .i_cry(w_switch_cry_06),
        .o_res(w_adder_num_a[6]),
        .o_cry(w_switch_cry_07),
        .o_cry_01bit(w_adder_num_b[7])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_7(
        .i_num(w_switch_num[7]),
        .i_cry(w_switch_cry_07),
        .o_res(w_adder_num_a[7]),
        .o_cry(w_switch_cry_08),
        .o_cry_01bit(w_adder_num_b[8])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_8(
        .i_num(w_switch_num[8]),
        .i_cry(w_switch_cry_08),
        .o_res(w_adder_num_a[8]),
        .o_cry(w_switch_cry_09),
        .o_cry_01bit(w_adder_num_b[9])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_9(
        .i_num(w_switch_num[9]),
        .i_cry(w_switch_cry_09),
        .o_res(w_adder_num_a[9]),
        .o_cry(w_switch_cry_10),
        .o_cry_01bit(w_adder_num_b[10])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_10(
        .i_num(w_switch_num[10]),
        .i_cry(w_switch_cry_10),
        .o_res(w_adder_num_a[10]),
        .o_cry(w_switch_cry_11),
        .o_cry_01bit(w_adder_num_b[11])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_11(
        .i_num(w_switch_num[11]),
        .i_cry(w_switch_cry_11),
        .o_res(w_adder_num_a[11]),
        .o_cry(w_switch_cry_12),
        .o_cry_01bit(w_adder_num_b[12])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_12(
        .i_num(w_switch_num[12]),
        .i_cry(w_switch_cry_12),
        .o_res(w_adder_num_a[12]),
        .o_cry(w_switch_cry_13),
        .o_cry_01bit(w_adder_num_b[13])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_13(
        .i_num(w_switch_num[13]),
        .i_cry(w_switch_cry_13),
        .o_res(w_adder_num_a[13]),
        .o_cry(w_switch_cry_14),
        .o_cry_01bit(w_adder_num_b[14])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_14(
        .i_num(w_switch_num[14]),
        .i_cry(w_switch_cry_14),
        .o_res(w_adder_num_a[14]),
        .o_cry(w_switch_cry_15),
        .o_cry_01bit(w_adder_num_b[15])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_15(
        .i_num(w_switch_num[15]),
        .i_cry(w_switch_cry_15),
        .o_res(w_adder_num_a[15]),
        .o_cry(w_switch_cry_16),
        .o_cry_01bit(w_adder_num_b[16])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_16(
        .i_num(w_switch_num[16]),
        .i_cry(w_switch_cry_16),
        .o_res(w_adder_num_a[16]),
        .o_cry(w_switch_cry_17),
        .o_cry_01bit(w_adder_num_b[17])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_17(
        .i_num(w_switch_num[17]),
        .i_cry(w_switch_cry_17),
        .o_res(w_adder_num_a[17]),
        .o_cry(w_switch_cry_18),
        .o_cry_01bit(w_adder_num_b[18])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_18(
        .i_num(w_switch_num[18]),
        .i_cry(w_switch_cry_18),
        .o_res(w_adder_num_a[18]),
        .o_cry(w_switch_cry_19),
        .o_cry_01bit(w_adder_num_b[19])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_19(
        .i_num(w_switch_num[19]),
        .i_cry(w_switch_cry_19),
        .o_res(w_adder_num_a[19]),
        .o_cry(w_switch_cry_20),
        .o_cry_01bit(w_adder_num_b[20])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_20(
        .i_num(w_switch_num[20]),
        .i_cry(w_switch_cry_20),
        .o_res(w_adder_num_a[20]),
        .o_cry(w_switch_cry_21),
        .o_cry_01bit(w_adder_num_b[21])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_21(
        .i_num(w_switch_num[21]),
        .i_cry(w_switch_cry_21),
        .o_res(w_adder_num_a[21]),
        .o_cry(w_switch_cry_22),
        .o_cry_01bit(w_adder_num_b[22])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_22(
        .i_num(w_switch_num[22]),
        .i_cry(w_switch_cry_22),
        .o_res(w_adder_num_a[22]),
        .o_cry(w_switch_cry_23),
        .o_cry_01bit(w_adder_num_b[23])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_23(
        .i_num(w_switch_num[23]),
        .i_cry(w_switch_cry_23),
        .o_res(w_adder_num_a[23]),
        .o_cry(w_switch_cry_24),
        .o_cry_01bit(w_adder_num_b[24])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_24(
        .i_num(w_switch_num[24]),
        .i_cry(w_switch_cry_24),
        .o_res(w_adder_num_a[24]),
        .o_cry(w_switch_cry_25),
        .o_cry_01bit(w_adder_num_b[25])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_25(
        .i_num(w_switch_num[25]),
        .i_cry(w_switch_cry_25),
        .o_res(w_adder_num_a[25]),
        .o_cry(w_switch_cry_26),
        .o_cry_01bit(w_adder_num_b[26])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_26(
        .i_num(w_switch_num[26]),
        .i_cry(w_switch_cry_26),
        .o_res(w_adder_num_a[26]),
        .o_cry(w_switch_cry_27),
        .o_cry_01bit(w_adder_num_b[27])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_27(
        .i_num(w_switch_num[27]),
        .i_cry(w_switch_cry_27),
        .o_res(w_adder_num_a[27]),
        .o_cry(w_switch_cry_28),
        .o_cry_01bit(w_adder_num_b[28])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_28(
        .i_num(w_switch_num[28]),
        .i_cry(w_switch_cry_28),
        .o_res(w_adder_num_a[28]),
        .o_cry(w_switch_cry_29),
        .o_cry_01bit(w_adder_num_b[29])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_29(
        .i_num(w_switch_num[29]),
        .i_cry(w_switch_cry_29),
        .o_res(w_adder_num_a[29]),
        .o_cry(w_switch_cry_30),
        .o_cry_01bit(w_adder_num_b[30])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_30(
        .i_num(w_switch_num[30]),
        .i_cry(w_switch_cry_30),
        .o_res(w_adder_num_a[30]),
        .o_cry(w_switch_cry_31),
        .o_cry_01bit(w_adder_num_b[31])
    );
    mul_01bitx08_wallace mul_01bitx08_wallace_inst_31(
        .i_num(w_switch_num[31]),
        .i_cry(w_switch_cry_31),
        .o_res(w_adder_num_a[31]),
        .o_cry(),
        .o_cry_01bit()
    );

    adder_xxbit_serial #(
        .DATA_WIDTH(32)
    ) adder_xxbit_serial_inst(
        .i_num_a(w_adder_num_a),
        .i_num_b(w_adder_num_b),
        .i_cry(w_adder_cry),
        .o_res(o_res),
        .o_cry(o_cry)
    );

endmodule
