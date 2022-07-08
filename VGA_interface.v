module VGA_interface (
    input   clk50,
    input[2:0] RGB,
    output H_sync_pin,V_sync_pin,Red,Green,Blue
);
wire clk65,ready, line_finish,dispaly ;

PLL_65 PLL(clk50,clk65,ready);

H_sync U1 (clk65,H_sync_pin,line_finish,dispaly);

V_sync U2 (line_finish,V_sync_pin);

assign Red   = (RGB[2] & dispaly );
assign Blue  = (RGB[0] & dispaly );
assign Green = (RGB[1] & dispaly );

endmodule 