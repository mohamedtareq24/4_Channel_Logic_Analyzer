module VGA_interface (  //1024*768
    input  clk65,reset,
    input  memo_out,write_finish_reg,
    output [2:0] RGBpin,
	output [9:0] pixel_number,
    output [9:0] line_number,
    output H_sync_pin,V_sync_pin
);
localparam red = 0 ,green = 1 ,blue = 2 ;
wire ready, line_finish,dispaly,out ;


H_sync U1 (clk65,H_sync_pin,line_finish,dispaly,pixel_number);

V_sync U2 (line_finish,V_sync_pin,line_number);

assign RGBpin[red]  = (line_number == 192 | line_number == 384 | line_number == 576);
wire line_equal ;
assign line_equal = write_finish_reg & (line_number == 170 | line_number == 12 | line_number == 372 | line_number == 214 | line_number == 564 | line_number == 406 | line_number == 756 | line_number == 598) & dispaly; 
display_FSM FSM(clk65,reset,{line_equal,memo_out},out);
assign RGBpin[blue] = out;
assign RGBpin[green] = out;

/*assign line[0] = (line_number >= 12  & line_number <= 170);
assign line[1] = (line_number >= 214 & line_number <= 372);
assign line[2] = (line_number >= 406 & line_number <= 564);
assign line[3] = (line_number >= 588 & line_number <= 764);*/
endmodule 
