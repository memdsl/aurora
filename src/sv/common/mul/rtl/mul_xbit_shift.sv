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

    logic [DATA_WIDTH * 2 - 1 : 0] w_res;

    int count;

    always_ff @(posedge i_clk) begin
        if (!i_rst_n) begin
            r_num_a <= {{DATA_WIDTH{i_num_a[DATA_WIDTH - 1]}}, i_num_a};
            r_num_b <= i_num_b;
            r_res   <= {(DATA_WIDTH * 2){1'b0}};
            count   <= 0;
        end
        else begin
            if (count == DATA_WIDTH) begin
                o_end <= 1'b1;
                o_res <= r_res + (~w_res + 1'b1);
                count <= count;
            end
            else begin
                o_end   <= 1'b0;
                o_res   <= {(DATA_WIDTH * 2){1'b0}};
                r_res   <= r_res + w_res;
                r_num_a <= (r_num_a << 1);
                r_num_b <= (r_num_b >> 1);
                count   <= count + 1'b1;
            end
        end
    end

    assign w_res = (r_num_b[0]) ? r_num_a : {(DATA_WIDTH * 2){1'b0}};

endmodule
