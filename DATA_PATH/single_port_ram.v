module single_port_ram 
#(parameter DATA_WIDTH=1, parameter ADDR_WIDTH=13)
(
	input [13:0] addr, 
	input  data, we, clk,
	output reg [13:0] addr_reg,
	output  q
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	// Variable to hold the registered read address
	

	always @ (posedge clk)
	begin
		// Write
		if (we)
			ram[addr[12:0]] <= data;

		addr_reg <= addr;
	end

	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign q = ram[addr_reg[12:0]];
	initial addr_reg = 14'b0;

endmodule
