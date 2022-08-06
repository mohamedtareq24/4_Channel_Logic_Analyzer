module H_sync (
    input  clk,         // clk = 65 MHz
    output pulse, finish,dispaly,
	output reg[10:0]  pixel 	 
);
localparam   whole_line = 11'd1344, visible_area = 11'd1024 , front_porch = 24, sync_pulse = 136  ;  // just put the timing http://tinyvga.com/vga-timing

always @( posedge clk) begin
    if (pixel < whole_line)
        pixel <= pixel + 1'b1 ;
    else
        pixel  <= 0 ;
  
end

assign pulse   =  (pixel < (visible_area + front_porch ) || pixel > (visible_area + front_porch + sync_pulse) ); // that's the pulse the monitor is looking for 
assign finish  =  (pixel == whole_line);
assign dispaly =  (pixel <= visible_area);  // when it's valid to put a pixel other wise nothing will be displayed 

endmodule //H_sync