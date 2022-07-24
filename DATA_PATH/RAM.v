module RAM 
    (
	input [13:0] addr, 
	input  data, we, clk,
	output [13:0] addr_reg,
	output  q
);
single_port_ram MEMORY (addr,data,we,clk,addr_reg,q);
endmodule //RAM