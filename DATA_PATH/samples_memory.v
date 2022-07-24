// Quartus Prime Verilog Template
// Single port RAM with single read/write address 

module samples_memory 
#( parameter ADDR_WIDTH=13)
(
 	input wire [3:0] zoom,
	input wire [2:0]offset,
	input datain,start,reset,
//	input [(ADDR_WIDTH-1):0] addr,
	input  clk,
	output  q
);
	wire data ;
	assign data  = (start) ? datain : 1'b0 ;
	// Declare the RAM variable
	reg  ram[2**13-1:0];  // whole block

	// Variable to hold the registered read address
	reg  [12:0] addr_reg;
	wire [12:0] addr;	
	wire WE ;
	
////////////////////////////////// RAM \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	always @ (posedge clk)
	begin
		// Write
		if (WE) // write enable from the FSM
			ram[addr] <= data;
		addr_reg <= addr;
	end

	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	wire increament ;
	assign q =  ram[addr_reg] ;
	
//////////////////////////////////////// Edge detecor\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	
	localparam A = 0 , B = 1, C = 2, D = 3;
	reg[1:0] state;
	always @(posedge clk ) begin
		if (reset) 
			state <= A;
		else	
			case (state)
				A : state <= (data) ? B : C ;
				B : state <= (data) ? B : D ;
				C : state <= (data) ? D : C ; 
			endcase
	end  
	assign WE = (state == D) ;
	
///////////////////////////////////////////////////////////////////////////////////////////////////////////
 wire [12:0] old_address;
 wire [12:0] read_address;
 assign old_address = addr_reg;
 RA_CTRL RActrl (old_address,zoom,offset,read_address);
	 
///////////////////////////////////////////////// WA COUNTER \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 

 /*
 assign increament = ~(WE & write_finish);
 always @(posedge clk ) begin
	 if (~WE) //coming from the FSM
		write_address <= 0;
	else
		write_address <= write_address + increament ;
	end
*/	 
wire [13:0] write_address ;
wire write_finish;
WA_CTRL WACOUNTER (clk,WE,write_address,write_finish);
assign addr  = (~write_finish) ? write_address[12:0] : read_address;
	
initial begin
	addr_reg = 13'b0 ; 
	state = 2'b0;
end

endmodule
