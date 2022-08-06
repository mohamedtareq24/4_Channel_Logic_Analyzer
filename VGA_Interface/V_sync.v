module V_sync (
  input  clk,         // clk = H_sync
  output pulse,
  output reg [9:0] line
);
localparam   whole_frame = 806, visible_area = 768 , front_porch = 3, sync_pulse = 6  ; 


always @( posedge clk) begin
    if (line < whole_frame)
        line <= line + 1'b1 ;
    else
        line  <= 0 ;       
end

assign pulse = (line < (visible_area + front_porch ) || line > (visible_area + front_porch + sync_pulse) ); 

endmodule //V_sync