module data_path (
    input datain,start,reset,clk,
    input wire [3:0] zoom,
	input wire [2:0]offset,
    output out
);
wire [13:0] addr_reg,addr,write_address,read_address;
assign read_address[13] = 1'b1;
wire data,we,q;
assign data = (start) ? datain : 1'b0 ;
assign out = (addr_reg[13]) ? q:1'b0 ;
RAM MEMORY (addr,data,we,clk,addr_reg,q);
edge_det detector(clk,data,reset,addr_reg[13],we);
WA_CTRL WA_counter(clk,we,addr_reg,write_address);
RA_CTRL RA_Counter(addr_reg[12:0],zoom,offset,read_address[12:0]);
assign addr = (reset)? 14'b0 :(addr_reg[13]) ? read_address : write_address ;

endmodule //data_path