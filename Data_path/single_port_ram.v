module single_port_ram 
#(parameter DATA_WIDTH=1, parameter ADDR_WIDTH=13)
(
	input [15:0] addr, 
	input  clk,
	input [3:0] data,we,
	output reg [15:0] addr_reg,
	output [3:0] q
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram0[2**ADDR_WIDTH-1:0],ram1[2**ADDR_WIDTH-1:0],ram2[2**ADDR_WIDTH-1:0],ram3[2**ADDR_WIDTH-1:0];

	// Variable to hold the registered read address
	

	always @ (posedge clk)
	begin
		// Write
		if (we[0])
			ram0[addr[12:0]] <= data[0];
		if (we[1])	
			ram1[addr[12:0]] <= data[1];
		if (we[2])	
			ram2[addr[12:0]] <= data[2];
		if (we[3])		
			ram3[addr[12:0]] <= data[3];
		addr_reg <= addr;
	end

	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign q[0] = ram0[addr_reg[12:0]];
	assign q[1] = ram1[addr_reg[12:0]];
	assign q[2] = ram2[addr_reg[12:0]];
	assign q[3] = ram3[addr_reg[12:0]];
	
	initial addr_reg = 14'b0;
	

endmodule
