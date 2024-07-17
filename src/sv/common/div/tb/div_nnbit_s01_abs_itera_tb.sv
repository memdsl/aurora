`timescale 1ns / 1ps

module div_nnbit_s01_abs_itera_tb();

initial begin
    $dumpfile("build/div_nnbit_s01_abs_itera.vcd");
    $dumpvars(0, div_nnbit_s01_abs_itera_tb);
end

parameter CYCLE      = 10;
parameter DATA_WIDTH = 8;

logic                      w_clk;
logic                      w_rst_n;
logic [DATA_WIDTH - 1 : 0] w_num_x;
logic [DATA_WIDTH - 1 : 0] w_num_y;

always #(CYCLE / 2) w_clk = ~w_clk;

initial begin
    w_clk   = 1'b0;
    w_rst_n = 1'b0;
    w_num_x = 8'b10010101;
    w_num_y = 8'b00011101;
    #(CYCLE * 1)
    w_rst_n = 1'b1;
    #(CYCLE * 50);
    $finish;
end

div_nnbit_s01_abs_itera #(
    .DATA_WIDTH(8)
) div_nnbit_s01_abs_itera_inst(
    .i_clk(w_clk),
    .i_rst_n(w_rst_n),
    .i_valid(1'b1),
    .i_signed(1'b1),
    .i_num_x(w_num_x),
    .i_num_y(w_num_y),
    .o_res(),
    .o_rem(),
    .o_valid()
);

endmodule