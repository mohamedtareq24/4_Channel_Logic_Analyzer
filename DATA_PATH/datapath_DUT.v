`timescale 1ps/1ps
module datapath_DUT ();
    reg [3:0] zoom;
	reg [2:0]offset;
	reg datain,start,reset;
	reg  clk;
	wire  q;
data_path path (datain,start,reset,clk,zoom,offset,q);



initial begin
    clk    = 0 ;
    offset = 0;
    zoom   = 1;
    start  = 1 ;
    reset  = 0;
    datain = 0 ; 
end
always
begin
    #100 clk =~clk;
end
always
begin
    #1000 datain =~ datain ;
end
endmodule //datapath_DUT