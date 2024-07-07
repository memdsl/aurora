module mul_xbit_wallace #(
    parameter DATA_WIDTH = 8
) (
    input  logic                          i_clk,
    input  logic                          i_rst_n,
    input  logic [DATA_WIDTH - 1     : 0] i_num_a,
    input  logic [DATA_WIDTH - 1     : 0] i_num_b,
    output logic                          o_end,
    output logic [DATA_WIDTH * 2 - 1 : 0] o_res
);



endmodule
