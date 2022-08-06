module VGA_Input_Control (
	input  clk, reset, SW1, SW2, SW3, SW4, SW5,
	output [1:0] smpl_clk_sel,
	output [3:0] LED,
	output [1:0] zoom, offset
);

	Smpl_Clk_Control U1 (.clk(clk), .i_SW5(SW5), .i_reset(reset), .smpl_clk_sel(smpl_clk_sel), .LED(LED));
	offset_ctrl      U2 (.clk(clk), .i_SW1(SW1), .i_SW2(SW2), .i_reset(reset), .offset(offset));
	Zoom_Ctrl        U3 (.clk(clk), .i_SW3(SW3), .i_SW4(SW4), .i_reset(reset), .zoom(zoom));

endmodule //VGA_Input_Control