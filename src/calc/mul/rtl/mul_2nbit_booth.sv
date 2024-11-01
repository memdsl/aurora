/*
 * @Author      : myyerrol
 * @Date        : 2024-07-02 18:48:41
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-09-08 18:23:20
 * @FilePath    : /memdsl/aurora/src/common/mul/rtl/mul_2nbit_booth.sv
 * @Description : 2nbit booth multiplier
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`include "mul_02bit_booth.sv"

module mul_2nbit_booth #(
    parameter DATA_WIDTH = 8
) (
    input  logic                          i_clk,
    input  logic                          i_rst_n,
    input  logic [DATA_WIDTH - 1     : 0] i_num_x,
    input  logic [DATA_WIDTH - 1     : 0] i_num_y,
    output logic                          o_end,
    output logic [DATA_WIDTH * 2 - 1 : 0] o_res,
    output logic                          o_cry
);

    logic [DATA_WIDTH * 2 - 1 : 0] r_num_x;
    logic [DATA_WIDTH         : 0] r_num_y;
    logic [DATA_WIDTH * 2 - 1 : 0] r_res;
    logic                          r_cry;

    logic [DATA_WIDTH * 2 - 1 : 0] w_res;

    int count;

    always_ff @(posedge i_clk) begin
        if (!i_rst_n) begin
            r_num_x <= {{DATA_WIDTH{i_num_x[DATA_WIDTH - 1]}}, i_num_x};
            r_num_y <= {i_num_y, 1'b0};
            r_res   <= {(DATA_WIDTH * 2){1'b0}};
            r_cry   <= 1'b0;
            count   <= 0;
        end
        else begin
            if (count == (DATA_WIDTH / 2) ||
                r_num_y == {(DATA_WIDTH + 1){1'b0}}) begin
                o_end <= 1'b1;
                o_res <= r_res;
                o_cry <= r_cry;
                count <= count;
            end
            else begin
                o_end          <= 1'b0;
                o_res          <= {(DATA_WIDTH * 2){1'b0}};
                o_cry          <= 1'b0;
                {r_cry, r_res} <= r_res + w_res + w_cry;
                r_num_x        <= (r_num_x << 2);
                r_num_y        <= (r_num_y >> 2);
                count          <= count + 1'b1;
            end
        end
    end

    mul_02bit_booth #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u_mul_02bit_booth(
        .i_num_x(r_num_x),
        .i_num_y(r_num_y[2 : 0]),
        .o_res(w_res),
        .o_cry(w_cry)
    );

endmodule
