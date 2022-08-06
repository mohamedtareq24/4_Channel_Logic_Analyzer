`timescale 10ns / 1ps //time unit - time precision

module VGA_Input_Control_tb;
	reg  clk, reset, SW1, SW2, SW3, SW4, SW5;
	wire [1:0] smpl_clk_sel;
	wire [3:0] LED;
	wire [1:0] zoom, offset;

	//unit under test 
	VGA_Input_Control UUT (.clk(clk), .reset(reset), .SW1(SW1), .SW2(SW2), .SW3(SW3), .SW4(SW4), .SW5(SW5),
		.smpl_clk_sel(smpl_clk_sel), .LED(LED), .zoom(zoom), .offset(offset));

	always #10 clk = ~clk;

	//initialization
	initial
	begin
		clk <= 0;
		reset <= 1;
		SW1 <= 1;
		SW2 <= 1;
		SW3 <= 1;
		SW4 <= 1;
		SW5 <= 1;
	end

	initial
	begin
		reset <= 0;
		#10 reset <= 1;

		repeat(5)@(posedge clk)
		begin
			#5 SW1 <= ~SW1;
			#5 SW1 <= ~SW1;
			#5 SW2 <= ~SW2;
			#5 SW2 <= ~SW2;
			#5 SW3 <= ~SW3;
			#5 SW3 <= ~SW3;
			#5 SW4 <= ~SW4;
			#5 SW4 <= ~SW4;

		end
		$finish;
	end


	initial //analysis
	    $monitor("reset=%0b, SW1=%b, SW2=%b, SW3=%b, SW4=%b, SW5=%b, smpl_clk_sel=%b, LED=%b, zoom=%b, offset=%b", reset, SW1, SW2, SW3, SW4, SW5, smpl_clk_sel, LED, zoom, offset);

endmodule

