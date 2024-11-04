//-- modified by xlinxdu, 2022/05/17
module fifo_tb;
  reg           rst_n_i  ;

  reg           wr_clk_i ;
  reg           wr_en_i  ;
  reg [15:0]    wr_data_i;

  reg           rd_clk_i ;
  reg           rd_en_i  ;
  wire [15:0]   rd_data_o;

  reg           full_o   ;
  reg           empty_o  ;

initial begin
  rst_n_i  = 1;
  wr_clk_i = 0;
  wr_en_i  = 0;
  wr_data_i= 16'b0;
  rd_clk_i = 0;
  rd_en_i  = 0;

  # 1 rst_n_i = 0;
  # 2 rst_n_i = 1;
end

initial begin
  #20 wr_en_i = 1;
      rd_en_i = 0;
  #40 wr_en_i = 0;
      rd_en_i = 1;
  #30 wr_en_i = 1 ;
      rd_en_i = 0 ;
  #13 rd_en_i = 1 ;
  #10
  repeat(100)
  begin
      #5 wr_en_i = {$random}%2 ;
         rd_en_i = {$random}%2 ;
    end
end

always #1.5 wr_clk_i  = ~wr_clk_i ;
always #1   rd_clk_i  = ~rd_clk_i ;
always #3   wr_data_i = {$random}%16'hFF;

fifo_mode_a #(
    .DATA_WIDTH(16),
    .FIFO_DEPTH(8)
) u_async_fifo(
                         .i_wr_rst_n(rst_n_i  ),
                         .i_wr_clk  (wr_clk_i ),
                         .i_wr_en   (wr_en_i  ),
                         .i_wr_data (wr_data_i),
                         .i_rd_rst_n(rst_n_i  ),
                         .i_rd_clk  (rd_clk_i ),
                         .i_rd_en   (rd_en_i  ),
                         .o_rd_data (rd_data_o),
                         .o_wr_full (full_o   ),
                         .o_rd_empty(empty_o  )
                       );

initial begin
    $dumpfile("build/fifo.vcd");
    $dumpvars(0, fifo_tb);
    #1000 $finish;
end

endmodule
