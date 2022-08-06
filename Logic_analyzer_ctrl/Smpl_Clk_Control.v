module Smpl_Clk_Control
(
	input	clk, i_SW5, i_reset,
	output reg [1:0] smpl_clk_sel,
	output reg [3:0] LED
);

	// Declare state register & wires
	reg		[1:0]state;
	reg		r_SW5 = 1'b0;
	wire reset, SW5;
	// Declare states
	parameter C0 = 0, C1 = 1, C2 = 2, C3 = 3;

	//instantiations
	Debounce_Switch U1 (.clk(clk), .i_Switch(i_SW5), .o_Switch(SW5));
	Debounce_Switch U2 (.clk(clk), .i_Switch(i_reset), .o_Switch(reset));

	// Output depends only on the state
	always @ (state) begin
		case (state)
			C0:begin
				smpl_clk_sel = 2'b00;
				LED  = 4'b1110;
			end
			C1:begin
				smpl_clk_sel = 2'b01;
				LED  = 4'b1100;
			end
			C2:begin
				smpl_clk_sel = 2'b10;
				LED  = 4'b1000;
			end
			C3:begin
				smpl_clk_sel = 2'b11;
				LED  = 4'b0000;
			end
			default:begin
				smpl_clk_sel = 2'b00;
				LED  = 4'b1110;
			end
		endcase
	end

	// Determine the next state
	always @ (posedge clk or negedge reset) begin
		if (!reset)
			state <= C0;
		else
			case (state)
				C0:
				if (SW5 == 1'b0 && r_SW5 == 1'b1)begin
					state <= C1;
				end
				else
					state <= C0;
				C1:
				if (SW5 == 1'b0 && r_SW5 == 1'b1)begin
					state <= C2;
				end
				else
				begin
					state <= C1;
				end
				C2:
				if (SW5 == 1'b0 && r_SW5 == 1'b1)begin
					state <= C3;
				end
				else
					state <= C2;
				C3:
				if (SW5 == 1'b0 && r_SW5 == 1'b1)begin
					state <= C0;
				end
				else
					state <= C3;
			endcase
	end

	always @ (posedge clk) begin
		r_SW5 <= SW5;
	end

endmodule