`timescale 1ns / 1ps

`include "adder_01bit_full.sv"

module mul_01bitx08_wallace_tb();

initial begin
    $dumpfile("build/mul_01bitx08_wallace.vcd");
    $dumpvars(0, mul_01bitx08_wallace_tb);
end

logic [7 : 0] w_num;
logic [5 : 0] w_cry;

initial begin
    w_num = 8'b0000_0010;
    w_cry = 6'b000000;
    #10;
    w_num = 8'b0000_0011;
    w_cry = 6'b000000;
    #10;
    w_num = 8'b0000_0110;
    w_cry = 6'b000000;
    #10;
    w_num = 8'b0000_1100;
    w_cry = 6'b000000;
    #10;
    w_num = 8'b0001_1000;
    w_cry = 6'b000000;
    #10;
    w_num = 8'b0011_0000;
    w_cry = 6'b000000;
    #10;
    w_num = 8'b0110_0000;
    w_cry = 6'b000000;
    #10;
    w_num = 8'b1100_0000;
    w_cry = 6'b000000;
    #10;
    $finish;
end

mul_01bitx08_wallace mul_01bitx08_wallace_inst(
    .i_num(w_num),
    .i_cry_06bit(w_cry),
    .o_cry_06bit(),
    .o_res(),
    .o_cry()
);

endmodule
