/*
 * @Author      : myyerrol
 * @Date        : 2024-07-07 22:20:40
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-12-10 15:01:14
 * @Description : 02bit booth multiplier
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

module mul_02bit_booth #(
    parameter DATA_WIDTH = 8
) (
    input  logic [2 * DATA_WIDTH - 1 : 0] i_num_x,
    input  logic [2                  : 0] i_num_y,
    output logic [2 * DATA_WIDTH - 1 : 0] o_res,
    output logic                          o_cry
);

    always @(i_num_y) begin
        case (i_num_y)
            3'b000,
            3'b111:  o_res = {(DATA_WIDTH * 2){1'b0}};
            3'b001,
            3'b010:  o_res =   i_num_x;
            3'b011:  o_res =  (i_num_x << 1);
            3'b100:  o_res = ~(i_num_x << 1);
            3'b101,
            3'b110:  o_res = ~i_num_x;
            default: o_res = {(DATA_WIDTH * 2){1'b0}};
        endcase
    end

    assign o_cry = (i_num_y == 3'b100 ||
                    i_num_y == 3'b101 ||
                    i_num_y == 3'b110) ? 1'b1 : 1'b0;

endmodule
