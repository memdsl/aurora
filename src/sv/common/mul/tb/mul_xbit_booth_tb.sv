`timescale 1ns / 1ps

module mul_xbit_booth_tb();

initial begin
    $dumpfile("build/mul_xbit_booth.vcd");
    $dumpvars(0, mul_xbit_booth_tb);
end

parameter CYCLE      = 10;
parameter DATA_WIDTH = 4;

logic                      w_clk;
logic                      w_rst_n;
logic [DATA_WIDTH - 1 : 0] w_num_a;
logic [DATA_WIDTH - 1 : 0] w_num_b;

always #(CYCLE / 2) w_clk = ~w_clk;

initial begin
    w_clk   = 1'b0;
    w_rst_n = 1'b0;
    w_num_a = 4'b1010;
    w_num_b = 4'b1001;
    #(CYCLE * 1);
    w_rst_n = 1'b1;
    #(CYCLE * 10);
    w_rst_n = 1'b0;
    w_num_a = 4'b1010;
    w_num_b = 4'b0101;
    #(CYCLE * 1);
    w_rst_n = 1'b1;
    #(CYCLE * 10);
    $finish;
end

mul_xbit_booth #(
    .DATA_WIDTH(DATA_WIDTH)
) mul_xbit_booth_inst(
    .i_clk(w_clk),
    .i_rst_n(w_rst_n),
    .i_num_a(w_num_a),
    .i_num_b(w_num_b),
    .o_end(),
    .o_res()
);

endmodule
