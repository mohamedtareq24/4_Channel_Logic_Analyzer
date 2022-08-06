module datapath2 (
    input start,reset,smpl_clk,clk65,
	 input [1:0] mode,
    input wire [2:0] zoom,
	 input wire [2:0]offset,
    input wire [3:0]datain,
    input [9:0] pixel_number,
    input [9:0] line_number,
    output Q,
	output reg write_finish_reg
);
wire [14:0] read_address;
wire we,clk_out,path_out,write_finish,write_finish_reg_clk;
wire [3:0] data,q ;
wire [1:0] clk_select;
assign data = (start) ? datain : 4'b0 ;
//assign out = (addr_reg[13]) ? q:1'b0 ;
//RAM MEMORY (addr,data,we,clk_out,addr_reg,q);
memory_blocks BLOCK (clk_out,reset,we,mode,data,read_address,q,write_finish);
edge_det trigger (smpl_clk,data[0],reset,write_finish,we);
read_organizer reader (q,read_address,mode,line_number,path_out);
//wire [15:0] old_address ;
//assign old_address = addr_reg;
//WA_CTRL WA_counter(we,old_address,write_address);
RA_CTRL RA_Counter(pixel_number,zoom,offset,read_address);

assign clk_select[1:0] =   {write_finish,~write_finish};
glitch_free_clock_mux GFCM ({clk65,smpl_clk},clk_select,clk_out);
assign  write_finish_reg_clk = (line_number == 10'd0);

always @(posedge write_finish_reg_clk) begin
    write_finish_reg <= write_finish ;
end
assign Q = (write_finish_reg)? path_out : 1'b0; 

endmodule //data_path