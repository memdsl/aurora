module sram_addr(
    input  logic          i_aclk,
    input  logic          i_areset_n,
    input  logic          i_rlast,
    output logic [ 7 : 0] o_araddr,
    output logic          o_arvalid
);

    logic [7 : 0] r_araddr;
    logic         r_arvalid;

    assign o_araddr  = r_araddr;
    assign o_arvalid = r_arvalid;

    always @(posedge i_aclk) begin
        if (!i_areset_n) begin
            r_araddr  <= 8'd1;
            r_arvalid <= 1'b1;
        end
        else begin
            if (i_rlast) begin
                r_araddr  <= r_araddr + 1'b1;
                r_arvalid <= 1'b1;
            end
            else begin
                r_araddr  <= r_araddr;
                r_arvalid <= 1'b0;
            end
        end
    end
endmodule
