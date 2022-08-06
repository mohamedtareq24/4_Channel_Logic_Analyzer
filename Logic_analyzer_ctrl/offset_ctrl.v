module offset_ctrl
(
	input	clk, i_SW1, i_SW2, i_reset,
	output reg [1:0] offset
);

	// Declare state register & wires
	reg		[1:0]state;
	reg		r_SW1 = 1'b0, r_SW2 = 1'b0;
	wire    reset, SW2, SW1;
	// Declare states
	parameter offset_0 = 0, offset_256 = 1, offset_512 = 2, offset_768 = 3;

	//instantiations
	Debounce_Switch U1 (.clk(clk), .i_Switch(i_SW1), .o_Switch(SW1));
	Debounce_Switch U2 (.clk(clk), .i_Switch(i_SW2), .o_Switch(SW2));
	Debounce_Switch U3 (.clk(clk), .i_Switch(i_reset), .o_Switch(reset));

	// Output depends only on the state
	always @ (state) begin
		case (state)
			offset_0:begin
				offset = 2'b00;
			end
			offset_256:begin
				offset = 2'b01;
			end
			offset_512:begin
				offset = 2'b10;
			end
			offset_768:begin
				offset = 2'b11;
			end
			default:begin
				offset = 2'b00;
			end
		endcase
	end

	// Determine the next state
	always @ (posedge clk or negedge reset) begin
		if (!reset)
			state <= offset_0;
		else
			case (state)
				offset_0:
				if (SW2 == 1'b0 && r_SW2 == 1'b1)begin
					state <= offset_256;
				end
				else
					state <= offset_0;
				offset_256:
				if (SW2 == 1'b0 && r_SW2 == 1'b1)begin
					state <= offset_512;
				end
				else if (SW1 == 1'b0 && r_SW1 == 1'b1)begin
					state <= offset_0;
				end
				else
					state <= offset_256;
				offset_512:
				if (SW2 == 1'b0 && r_SW2 == 1'b1)begin
					state <= offset_768;
				end
				else if (SW1 == 1'b0 && r_SW1 == 1'b1)begin
					state <= offset_256;
				end
				else
					state <= offset_512;
				offset_768:
				if (SW1 == 1'b0 && r_SW1 == 1'b1)begin
					state <= offset_512;
				end
				else
					state <= offset_768;
			endcase
	end

	always @ (posedge clk) begin
		r_SW1 <= SW1;
		r_SW2 <= SW2;
	end

endmodule