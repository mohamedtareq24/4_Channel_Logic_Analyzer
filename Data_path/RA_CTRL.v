module RA_CTRL (
    input wire [9:0] pixel_number, //HSYNC
    input wire [2:0] zoom, //max 5
	 input wire [2:0]offset,
    output [14:0] read_address
);
 

assign read_address = (pixel_number << zoom)+ {3'b0,offset,8'b0} ;

endmodule //RA_CTRL