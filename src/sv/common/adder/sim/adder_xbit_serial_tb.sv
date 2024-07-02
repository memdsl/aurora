/*
 * @Author      : myyerrol
 * @Date        : 2024-06-28 14:52:18
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-07-02 23:43:41
 * @FilePath    : /memdsl-cpu/aurora/src/sv/common/adder/sim/adder_xbit_serial_tb.sv
 * @Description : xbit serial carry adder testbench
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

`timescale 1ns / 1ps

module adder_xbit_serial_tb();

initial begin
    $dumpfile("build/adder_xbit_serial.vcd");
    $dumpvars(0, adder_xbit_serial_tb);
end

parameter DATA_WIDTH = 4;

logic [DATA_WIDTH - 1 : 0] w_num_a;
logic [DATA_WIDTH - 1 : 0] w_num_b;
logic                      w_cry;

initial begin
        w_num_a = 4'b0000; w_num_b = 4'b0000; w_cry = 0;
    #10 w_num_a = 4'b1111; w_num_b = 4'b1111; w_cry = 0;
    #10 w_num_a = 4'b1100; w_num_b = 4'b1001; w_cry = 0;
    #10 w_num_a = 4'b0111; w_num_b = 4'b0110; w_cry = 0;
    #10 w_num_a = 4'b0101; w_num_b = 4'b0101; w_cry = 1;
    #10 w_num_a = 4'b1110; w_num_b = 4'b1001; w_cry = 1;
    #10 w_num_a = 4'b0010; w_num_b = 4'b0110; w_cry = 1;
    #10 w_num_a = 4'b0110; w_num_b = 4'b1100; w_cry = 1;
    #10 $finish;
end

adder_xbit_serial #(
    .DATA_WIDTH(DATA_WIDTH)
) adder_xbit_serial_inst(
    .i_num_a(w_num_a),
    .i_num_b(w_num_b),
    .i_cry(w_cry),
    .o_res(),
    .o_cry()
);

endmodule
