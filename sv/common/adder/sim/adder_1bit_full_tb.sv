`timescale 1ns / 1ps

module adder_1bit_full_tb();

initial begin
    $dumpfile("build/adder_1bit_full.vcd");
    $dumpvars();
end

logic w_num_a;
logic w_num_b;
logic w_cry;

initial begin
        w_num_a = 0; w_num_b = 0; w_cry = 0;
    #10 w_num_a = 0; w_num_b = 1; w_cry = 0;
    #10 w_num_a = 1; w_num_b = 0; w_cry = 0;
    #10 w_num_a = 1; w_num_b = 1; w_cry = 0;
    #10 w_num_a = 0; w_num_b = 0; w_cry = 1;
    #10 w_num_a = 0; w_num_b = 1; w_cry = 1;
    #10 w_num_a = 1; w_num_b = 0; w_cry = 1;
    #10 w_num_a = 1; w_num_b = 1; w_cry = 1;
    #10 $finish;
end

adder_1bit_full adder_1bit_full_inst(
    .i_num_a(w_num_a),
    .i_num_b(w_num_b),
    .i_cry(w_cry),
    .o_res(),
    .o_cry()
);

endmodule
