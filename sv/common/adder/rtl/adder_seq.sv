`include "adder_full_1bit.sv"

module adder_seq #(
    parameter DATA_WIDTH = 8
) (
    input  logic [DATA_WIDTH - 1] i_num_a,
    input  logic [DATA_WIDTH - 1] i_num_b,
    input  logic                  i_cry,
    output logic [DATA_WIDTH - 1] o_res,
    output logic                  o_cry
);

    logic [DATA_WIDTH - 1 : 0] w_res;
    logic [DATA_WIDTH - 1 : 0] w_cry;

    generate
        genvar i;
        for (i = 0; i < DATA_WIDTH; i = i + 1)
        begin: adder_seq
            adder_full_1bit adder_full_1bit_inst(
                .i_num_a(i_num_a[i]),
                .i_num_b(i_num_b[i]),
                .i_cry((i == 0) ? i_cry : w_cry[i - 1]),
                .o_res(w_res[i]),
                .o_cry(w_cry[i])
            );
        end
    endgenerate

    assign o_res = w_res;
    assign o_cry = w_cry[DATA_WIDTH - 1];

endmodule
