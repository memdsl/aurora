`timescale 1ns / 1ps

module mul_01bitx08_wallace_tb();

initial begin
    $dumpfile("build/mul_01bitx08_wallace.vcd");
    $dumpvars(0, mul_01bitx08_wallace_tb);
end

logic [7 : 0] w_num;
logic [5 : 0] w_cry;

initial begin
    w_num = 8'b00001010;
    w_cry = 6'b000000;
    #10;
    $finish;
end

mul_01bitx08_wallace mul_01bitx08_wallace_inst(
    .i_num(w_num),
    .i_cry(w_cry),
    .o_res(),
    .o_cry(),
    .o_cry_01bit()
);

endmodule
