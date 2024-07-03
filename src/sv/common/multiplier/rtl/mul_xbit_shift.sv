module mul_xbit_shift #(
    parameter DATA_WIDTH = 8
) (
    input  logic                          i_clk,
    input  logic                          i_rst_n,
    input  logic [DATA_WIDTH - 1     : 0] i_num_a,
    input  logic [DATA_WIDTH - 1     : 0] i_num_b,
    output logic                          o_end,
    output logic [DATA_WIDTH * 2 - 1 : 0] o_res
);

    logic [DATA_WIDTH * 2 - 1 : 0] r_num_a;
    logic [DATA_WIDTH     - 1 : 0] r_num_b;
    logic [DATA_WIDTH * 2 - 1 : 0] r_res;

    int count;

    always_ff @(posedge i_clk) begin
        if (!i_rst_n) begin
            r_num_a <= {{DATA_WIDTH{i_num_a[DATA_WIDTH - 1]}}, i_num_a};
            r_num_b <= i_num_b;
            r_res   <= {(DATA_WIDTH * 2){1'b0}};
            count   <= 0;
        end
        else begin
            if (count == DATA_WIDTH - 1) begin
                o_end <= 1'b1;
                o_res <= r_res + (~r_num_a + 1'b1);
                count <= count;
            end
            else begin
                o_end <= 1'b0;
                if (r_num_b[0]) begin
                    r_res <= r_res + r_num_a;
                end
                else begin
                    r_res <= r_res;
                end
                r_num_b <= {1'b0, r_num_b[DATA_WIDTH - 1 : 1]};
                r_num_a <= {r_num_a[DATA_WIDTH * 2 - 2 : 0], 1'b0};
                count <= count + 1'b1;
            end
        end
    end

endmodule
