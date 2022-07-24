module RA_CTRL (
    input wire [12:0] old_address,
    input wire [3:0] zoom,
	input wire [2:0]offset,
    output reg[12:0] read_address
);

initial read_address = 13'b0; 
always @(*) begin
	 read_address  = old_address + zoom ;
    case (zoom)
        2: read_address[12:10] = {2'b0,read_address[10]} ;
        4: read_address[12:10] = {1'b0,read_address[11],read_address[10]} ;
        8: read_address[12:10] = {read_address[12],read_address[11],read_address[10]} ;
        default  :
            read_address[12:10]= {3'b0} ;
    endcase
    read_address = read_address + {offset,8'b0} ;
end

endmodule //RA_CTRL