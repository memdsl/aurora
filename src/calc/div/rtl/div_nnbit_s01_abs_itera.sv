/*
 * @Author      : myyerrol
 * @Date        : 2024-07-16 20:05:41
 * @LastEditors : myyerrol
 * @LastEditTime: 2024-12-10 15:01:03
 * @Description : 01bit absolute value iterative divider
 *
 * Copyright (c) 2024 by myyerrol, All Rights Reserved.
 */

module div_nnbit_s01_abs_itera #(
    parameter DATA_WIDTH = 8
) (
    input  logic                      i_clk,
    input  logic                      i_rst_n,
    input  logic                      i_valid,
    input  logic                      i_signed,
    input  logic [DATA_WIDTH - 1 : 0] i_num_x,
    input  logic [DATA_WIDTH - 1 : 0] i_num_y,
    output logic [DATA_WIDTH - 1 : 0] o_res,
    output logic [DATA_WIDTH - 1 : 0] o_rem,
    output logic                      o_valid
);

    parameter S_IDLE     = 4'b0001;
    parameter S_DATA_IN  = 4'b0010;
    parameter S_CALC     = 4'b0100;
    parameter S_DATA_OUT = 4'b1000;

    int count;

    logic [3 : 0] r_state_curr;
    logic [3 : 0] r_state_next;

    logic                          r_res_pos;
    logic                          r_rem_pos;
    logic [DATA_WIDTH * 2 - 1 : 0] r_num_x_abs;
    logic [DATA_WIDTH * 2 - 1 : 0] r_num_y_abs;
    logic [DATA_WIDTH - 1 : 0]     r_res;
    logic [DATA_WIDTH * 2 - 1 : 0] r_rem;

    logic [DATA_WIDTH * 2 - 1 : 0] w_num_t;

    always_ff @(posedge i_clk) begin
        if (!i_rst_n) begin
            count <= 0;
        end
        else begin
            if (count == 1 + DATA_WIDTH + 1) begin
                count <= count;
            end
            else begin
                count <= count + 1;
            end
        end
    end

    always_ff @(posedge i_clk) begin
        if (!i_rst_n) begin
            r_state_curr <= S_IDLE;
        end
        else begin
            r_state_curr <= r_state_next;
        end
    end

    always_comb begin
        case (r_state_curr)
            S_IDLE: begin
                if (i_valid) begin
                    r_state_next = S_DATA_IN;
                end
                else begin
                    r_state_next = r_state_curr;
                end
            end
            S_DATA_IN: begin
                r_state_next = S_CALC;
            end
            S_CALC: begin
                if (count == 1 + DATA_WIDTH) begin
                    r_state_next = S_DATA_OUT;
                end
                else begin
                    r_state_next = r_state_curr;
                end
            end
            S_DATA_OUT: begin
                r_state_next = S_IDLE;
            end
            default: begin
                r_state_next = r_state_curr;
            end
        endcase
    end

    always_ff @(posedge i_clk) begin
        if (!i_rst_n) begin
            o_res   <= {DATA_WIDTH{1'b0}};
            o_rem   <= {DATA_WIDTH{1'b0}};
            o_valid <=  1'b0;
        end
        else begin
            case (r_state_curr)
                S_IDLE: begin
                    o_res   <= {DATA_WIDTH{1'b0}};
                    o_rem   <= {DATA_WIDTH{1'b0}};
                    o_valid <=  1'b0;
                end
                S_DATA_IN: begin
                    o_res   <= {DATA_WIDTH{1'b0}};
                    o_rem   <= {DATA_WIDTH{1'b0}};
                    o_valid <=  1'b0;
                end
                S_CALC: begin
                    o_res   <= {DATA_WIDTH{1'b0}};
                    o_rem   <= {DATA_WIDTH{1'b0}};
                    o_valid <=  1'b0;
                end
                S_DATA_OUT: begin
                    if (i_signed) begin
                        o_res <= (r_res_pos) ? r_res : (~r_res + 1'b1);
                        o_rem <= (r_rem_pos) ?
                                  r_rem[DATA_WIDTH - 1 : 0] :
                                (~r_rem[DATA_WIDTH - 1 : 0] + 1'b1);
                    end
                    else begin
                        o_res <= r_res;
                        o_rem <= r_rem[DATA_WIDTH - 1 : 0];
                    end
                    o_valid <= 1'b1;
                end
                default: begin
                    o_res   <= {DATA_WIDTH{1'b0}};
                    o_rem   <= {DATA_WIDTH{1'b0}};
                    o_valid <=  1'b0;
                end
            endcase
        end
    end

    always_ff @(posedge i_clk) begin
        if (!i_rst_n) begin
            r_res_pos   <= 1'b0;
            r_rem_pos   <= 1'b0;
            r_num_x_abs <= {(DATA_WIDTH * 2 - 1){1'b0}};
            r_num_y_abs <= {(DATA_WIDTH * 2 - 1){1'b0}};
            r_res       <= {DATA_WIDTH{1'b0}};
            r_rem       <= {DATA_WIDTH{1'b0}};
        end
        else begin
            case (r_state_curr)
                S_IDLE: begin
                    r_res_pos   <= 1'b0;
                    r_rem_pos   <= 1'b0;
                    r_num_x_abs <= {(DATA_WIDTH * 2 - 1){1'b0}};
                    r_num_y_abs <= {(DATA_WIDTH * 2 - 1){1'b0}};
                end
                S_DATA_IN: begin
                    if (i_signed) begin
                        r_res_pos   <= ~(i_num_x[DATA_WIDTH - 1] ^
                                         i_num_y[DATA_WIDTH - 1]);
                        r_rem_pos   <=  ~i_num_x[DATA_WIDTH - 1];
                        r_num_x_abs <= {
                            {DATA_WIDTH{1'b0}},
                            (i_num_x[DATA_WIDTH - 1] == 1'b0) ? i_num_x :
                            (~i_num_x + 1'b1) };
                        r_num_y_abs <= {
                            1'b0,
                            (i_num_y[DATA_WIDTH - 1] == 1'b0) ? i_num_y :
                            (~i_num_y + 1'b1), {(DATA_WIDTH - 1){1'b0}} };
                    end
                    else begin
                        r_res_pos   <= 1'b0;
                        r_rem_pos   <= 1'b0;
                        r_num_x_abs <= {{DATA_WIDTH{1'b0}}, i_num_x };
                        r_num_y_abs <= {1'b0, i_num_y, {(DATA_WIDTH - 1){1'b0}} };
                    end
                end
                S_CALC: begin
                    r_res       <= {r_res[6 : 0],
                                    ~w_num_t[DATA_WIDTH * 2 - 1] };
                    r_num_y_abs <= r_num_y_abs >> 1;
                    r_num_x_abs <= w_num_t[DATA_WIDTH * 2 - 1] ? r_num_x_abs :
                                   w_num_t;
                    r_rem       <= w_num_t[DATA_WIDTH * 2 - 1] ? r_num_x_abs :
                                   w_num_t;
                end
                S_DATA_OUT: begin
                end
                default: begin
                end
            endcase
        end
    end

    assign w_num_t = r_num_x_abs - r_num_y_abs;

endmodule
