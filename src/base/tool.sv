/*
 * @Author      : myyerrol
 * @Date        : 2024-11-02 15:41:19
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-11-02 16:00:42
 * @Description : Tools.
 *
 * Copyright (c) 2024 by MEMDSL, All Rights Reserved.
 */

module tool_bin_2_gry #(
    parameter DATA_WIDTH = 32
) (
    input  logic [DATA_WIDTH - 1 : 0] i_bin,
    output logic [DATA_WIDTH - 1 : 0] o_gry
);

    assign o_gry = i_bin ^ (i_bin >> 1);

endmodule

module tool_gry_2_bin #(
    parameter DATA_WIDTH = 32
) (
    input  logic [DATA_WIDTH - 1 : 0] i_gry,
    output logic [DATA_WIDTH - 1 : 0] o_bin
);

    assign o_bin[DATA_WIDTH - 1] = i_gry[DATA_WIDTH - 1];

    genvar i;
    generate
        for (i = 0; i <= DATA_WIDTH - 2; i++) begin
            assign o_bin[i] = o_bin[i + 1] ^ i_gry[i];
        end
    endgenerate

endmodule
