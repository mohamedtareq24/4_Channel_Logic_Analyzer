module edge_det 
(
    input clk ,data,reset,write_finish,
    output reg we    
 );

	// Declare state register
	reg		[2:0]state;
initial begin
	state = 0 ; we = 0;
end
	// Declare states
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;

	// Determine the next state synchronously, based on the
	// current state and the input
	always @ (posedge clk or posedge reset) begin
		if (reset)
			state <= S0;
		else
			case (state)
				S0:
					if (data)
					begin
						state <= S1;
					end
					else
					begin
						state <= S2;
					end
				S1:
					if (data)
					begin
						state <= S1;
					end
					else
					begin
						state <= S3;
					end
				S2:
					if (data)
					begin
						state <= S3;
					end
					else
					begin
						state <= S2;
					end
				S3:
					if (write_finish)
					begin
						state <= S4;
					end
					else
					begin
						state <= S3;
					end
				S4:
					state <= S4;	
				default:
					state <=S0;
			endcase
	end

	// Determine the weput based only on the current state
	// and the input (do not wait for a clock edge).
	always @ (state or data or write_finish)
	begin
			case (state)
				S0:
					if (data)
					begin
						we = 0;
					end
					else
					begin
						we = 0;
					end
				S1:
					if (data)
					begin
						we = 0;
					end
					else
					begin
						we = 1;
					end
				S2:
					if (data)
					begin
						we = 1;
					end
					else
					begin
						we = 0;
					end
				S3:
					if (write_finish)
					begin
						we = 0;
					end
					else
					begin
						we = 1;
					end
				S4:
					we = 0;
				
				default:
					we = 0;
			endcase
	end
endmodule //edge_det