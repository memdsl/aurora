module mul_xbit_booth #(
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
    logic [DATA_WIDTH         : 0] r_num_b;
    logic [DATA_WIDTH * 2 - 1 : 0] r_res;

    logic                          w_sx_f;
    logic                          w_sx_t;
    logic                          w_s2x_f;
    logic                          w_s2x_t;
    logic [DATA_WIDTH * 2 - 1 : 0] w_res;
    logic                          w_cry;

    int count;

    always_ff @(posedge i_clk) begin
        if (!i_rst_n) begin
            r_num_a <= {{DATA_WIDTH{i_num_a[DATA_WIDTH - 1]}}, i_num_a};
            r_num_b <= {i_num_b, 1'b0};
            r_res   <= {(DATA_WIDTH * 2){1'b0}};
            count   <= 0;
        end
        else begin
            if (count == (DATA_WIDTH / 2) || r_num_b == {(DATA_WIDTH + 1){1'b0}}) begin
                o_end <= 1'b1;
                o_res <= r_res;
                count <= count;
            end
            else begin
                o_end   <= 1'b0;
                o_res   <= {(DATA_WIDTH * 2){1'b0}};
                r_res   <= r_res + w_res;
                r_num_a <= (r_num_a << 2);
                r_num_b <= (r_num_b >> 2);
                count   <= count + 1'b1;
            end
        end
    end

    always_comb begin
        unique case (r_num_b[2 : 0])
            3'b000,
            3'b111:  w_res = {(DATA_WIDTH * 2){1'b0}};
            3'b001,
            3'b010:  w_res = r_num_a;
            3'b011:  w_res = (r_num_a << 1);
            3'b100:  w_res = (~(r_num_a << 1) + 1'b1);
            3'b101,
            3'b110:  w_res = (~r_num_a + 1'b1);
            default: w_res = {(DATA_WIDTH * 2){1'b0}};
        endcase
    end

endmodule
