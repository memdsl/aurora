/*
 * @Author      : myyerrol
 * @Date        : 2024-07-02 18:48:41
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-07-07 12:37:07
 * @FilePath    : /memdsl/aurora/src/sv/common/mul/rtl/mul_xxbit_booth.sv
 * @Description : xxbit booth multiplier (integer multiple of 2)
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

module mul_xxbit_booth #(
    parameter DATA_WIDTH = 8
) (
    input  logic                          i_clk,
    input  logic                          i_rst_n,
    input  logic [DATA_WIDTH - 1     : 0] i_num_a,
    input  logic [DATA_WIDTH - 1     : 0] i_num_b,
    output logic                          o_end,
    output logic [DATA_WIDTH * 2 - 1 : 0] o_res,
    output logic                          o_cry
);

    logic [DATA_WIDTH * 2 - 1 : 0] r_num_a;
    logic [DATA_WIDTH         : 0] r_num_b;
    logic [DATA_WIDTH * 2 - 1 : 0] r_res;
    logic                          r_cry;

    logic                          w_sx_f;
    logic                          w_sx_t;
    logic                          w_s2x_f;
    logic                          w_s2x_t;
    logic [DATA_WIDTH * 2 - 1 : 0] w_res;

    int count;

    always_ff @(posedge i_clk) begin
        if (!i_rst_n) begin
            r_num_a <= {{DATA_WIDTH{i_num_a[DATA_WIDTH - 1]}}, i_num_a};
            r_num_b <= {i_num_b, 1'b0};
            r_res   <= {(DATA_WIDTH * 2){1'b0}};
            r_cry   <= 1'b0;
            count   <= 0;
        end
        else begin
            if (count == (DATA_WIDTH / 2) ||
                r_num_b == {(DATA_WIDTH + 1){1'b0}}) begin
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
                r_num_a        <= (r_num_a << 2);
                r_num_b        <= (r_num_b >> 2);
                count          <= count + 1'b1;
            end
        end
    end

    always @(r_num_b[2 : 0]) begin
        case (r_num_b[2 : 0])
            3'b000,
            3'b111:  w_res = {(DATA_WIDTH * 2){1'b0}};
            3'b001,
            3'b010:  w_res =   r_num_a;
            3'b011:  w_res =  (r_num_a << 1);
            3'b100:  w_res = ~(r_num_a << 1);
            3'b101,
            3'b110:  w_res = ~r_num_a;
            default: w_res = {(DATA_WIDTH * 2){1'b0}};
        endcase
    end

    assign w_cry = (r_num_b[2 : 0] == 3'b100 ||
                    r_num_b[2 : 0] == 3'b101 ||
                    r_num_b[2 : 0] == 3'b110) ? 1'b1 : 1'b0;

endmodule
