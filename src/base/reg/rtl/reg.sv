`timescale 1ns / 1ps

`define DELAY_CYCLE 0

module reg_check_data_x #(
    parameter DATA_WIDTH = 32
) (
    input logic                      i_clk,
    input logic [DATA_WIDTH - 1 : 0] i_data
);

    assert property (@(posedge i_clk) ((^i_data) !== 1'bx))
    else $fatal("\nError! X value is detected! This should never happen.\n");

endmodule

module reg_rst_n_mode_n_en_n #(
    parameter DATA_WIDTH = 32
) (
    input  logic                      i_clk,
    input  logic [DATA_WIDTH - 1 : 0] i_data,
    output logic [DATA_WIDTH - 1 : 0] o_data
);

    logic [DATA_WIDTH - 1 : 0] r_data;

    always_ff @(posedge i_clk) begin
        r_data <= #`DELAY_CYCLE i_data;
    end

    assign o_data = r_data;

`ifndef RTL_SYN
    reg_check_data_x #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u_reg_check_data_x(
        .i_clk (i_clk),
        .i_data(i_data)
    );
`endif

endmodule

module reg_rst_n_mode_n_en_y #(
    parameter DATA_WIDTH = 32
) (
    input  logic                      i_clk,
    input  logic                      i_en,
    input  logic [DATA_WIDTH - 1 : 0] i_data,
    output logic [DATA_WIDTH - 1 : 0] o_data
);

    logic [DATA_WIDTH - 1 : 0] r_data;

    always_ff @(posedge i_clk) begin
        if (i_en) begin
            r_data <= #`DELAY_CYCLE i_data;
        end
        else begin
            r_data <= #`DELAY_CYCLE r_data;
        end
    end

    assign o_data = r_data;

`ifndef RTL_SYN
    reg_check_data_x #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u_reg_check_data_x(
        .i_clk (i_clk),
        .i_data(i_data)
    );
`endif

endmodule

module reg_rst_y_mode_s_en_n #(
    parameter DATA_WIDTH = 32
) (
    input  logic                      i_clk,
    input  logic                      i_rst_n,
    input  logic [DATA_WIDTH - 1 : 0] i_data,
    output logic [DATA_WIDTH - 1 : 0] o_data
);

    logic [DATA_WIDTH - 1 : 0] r_data;

    always_ff @(posedge i_clk) begin
        if (!i_rst_n) begin
            r_data <= {DATA_WIDTH{1'b0}};
        end
        else begin
            r_data <= i_data;
        end
    end

    assign o_data = r_data;

`ifndef RTL_SYN
    reg_check_data_x #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u_reg_check_data_x(
        .i_clk (i_clk),
        .i_data(i_data)
    );
`endif

endmodule


module reg_rst_y_mode_s_en_y #(
    parameter DATA_WIDTH = 32
) (
    input  logic                      i_clk,
    input  logic                      i_rst_n,
    input  logic                      i_en,
    input  logic [DATA_WIDTH - 1 : 0] i_data,
    output logic [DATA_WIDTH - 1 : 0] o_data
);

    logic [DATA_WIDTH - 1 : 0] r_data;

    always_ff @(posedge i_clk) begin
        if (!i_rst_n) begin
            r_data <= {DATA_WIDTH{1'b0}};
        end
        else if (i_en) begin
            r_data <= i_data;
        end
        else begin
            r_data <= r_data;
        end
    end

    assign o_data = r_data;

`ifndef RTL_SYN
    reg_check_data_x #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u_reg_check_data_x(
        .i_clk (i_clk),
        .i_data(i_data)
    );
`endif

endmodule

module reg_rst_y_mode_a_en_n #(
    parameter DATA_WIDTH = 32
) (
    input  logic                      i_clk,
    input  logic                      i_rst_n,
    input  logic [DATA_WIDTH - 1 : 0] i_data,
    output logic [DATA_WIDTH - 1 : 0] o_data
);

    logic [DATA_WIDTH - 1 : 0] r_data;

    always_ff @(posedge i_clk or negedge i_rst_n) begin
        if (!i_rst_n) begin
            r_data <= {DATA_WIDTH{1'b0}};
        end
        else begin
            r_data <= i_data;
        end
    end

    assign o_data = r_data;

`ifndef RTL_SYN
    reg_check_data_x #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u_reg_check_data_x(
        .i_clk (i_clk),
        .i_data(i_data)
    );
`endif

endmodule

module reg_rst_y_mode_a_en_y #(
    parameter DATA_WIDTH = 32
) (
    input  logic                      i_clk,
    input  logic                      i_rst_n,
    input  logic                      i_en,
    input  logic [DATA_WIDTH - 1 : 0] i_data,
    output logic [DATA_WIDTH - 1 : 0] o_data
);

    logic [DATA_WIDTH - 1 : 0] r_data;

    always_ff @(posedge i_clk or negedge i_rst_n) begin
        if (!i_rst_n) begin
            r_data <= {DATA_WIDTH{1'b0}};
        end
        else if (i_en) begin
            r_data <= i_data;
        end
        else begin
            r_data <= r_data;
        end
    end

    assign o_data = r_data;

`ifndef RTL_SYN
    reg_check_data_x #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u_reg_check_data_x(
        .i_clk (i_clk),
        .i_data(i_data)
    );
`endif

endmodule
