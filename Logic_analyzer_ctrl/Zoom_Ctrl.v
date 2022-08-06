module Zoom_Ctrl
(
	input	clk, i_SW3, i_SW4, i_reset,
	output reg [1:0] zoom
);

	// Declare state register & wires
	reg		[1:0]state;
	reg		r_SW3 = 1'b0, r_SW4 = 1'b0;
	wire reset, SW4, SW3;
	// Declare states
	parameter Zoom_x1 = 0, Zoom_x2 = 1, Zoom_x4 = 2, Zoom_x8 = 3;

	//instantiations
	Debounce_Switch U1 (.clk(clk), .i_Switch(i_SW3), .o_Switch(SW3));
	Debounce_Switch U2 (.clk(clk), .i_Switch(i_SW4), .o_Switch(SW4));
	Debounce_Switch U3 (.clk(clk), .i_Switch(i_reset), .o_Switch(reset));

	// Output depends only on the state
	always @ (state) begin
		case (state)
			Zoom_x1:begin
				zoom = 2'b00;
			end
			Zoom_x2:begin
				zoom = 2'b01;
			end
			Zoom_x4:begin
				zoom = 2'b10;
			end
			Zoom_x8:begin
				zoom = 2'b11;
			end
			default:begin
				zoom = 2'b00;
			end
		endcase
	end

	// Determine the next state
	always @ (posedge clk or negedge reset) begin
		if (!reset)
			state <= Zoom_x1;
		else
			case (state)
				Zoom_x1:
				if (SW4 == 1'b0 && r_SW4 == 1'b1)begin
					state <= Zoom_x2;
				end
				else
					state <= Zoom_x1;
				Zoom_x2:
				if (SW4 == 1'b0 && r_SW4 == 1'b1)begin
					state <= Zoom_x4;
				end
				else if (SW3 == 1'b0 && r_SW3 == 1'b1)begin
					state <= Zoom_x1;
				end
				else
					state <= Zoom_x2;
				Zoom_x4:
				if (SW4 == 1'b0 && r_SW4 == 1'b1)begin
					state <= Zoom_x8;
				end
				else if (SW3 == 1'b0 && r_SW3 == 1'b1)begin
					state <= Zoom_x2;
				end
				else
					state <= Zoom_x4;
				Zoom_x8:
				if (SW3 == 1'b0 && r_SW3 == 1'b1)begin
					state <= Zoom_x4;
				end
				else
					state <= Zoom_x8;
			endcase
	end

	always @ (posedge clk) begin
		r_SW3 <= SW3;
		r_SW4 <= SW4;
	end

endmodule