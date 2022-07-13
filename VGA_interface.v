module VGA_interface (
    input   clk50,
    output  [2:0] RGBpins,
    output H_sync_pin,V_sync_pin   
 );
 
    wire clk40,ready,line_finish,dispaly ;
    wire  RGBh, RGBv; //flags 
	 wire [24:0] RGBh25,RGBv25;
	
    wire[10:0] line_number ,pixel_number ;
	PLL_40 PLL(clk50,clk40,ready);

    H_sync U1 (clk40,H_sync_pin,line_finish,dispaly,pixel_number);

    V_sync U2 (line_finish,V_sync_pin,line_number);

////    equal U40(pixel_number, 0 ,RGBv25[0]);
////	 equal U10(pixel_number, 800 ,RGBv25[24]);
//	 equal U20(line_number, 0 ,RGBh25[0]);
//	 equal U30(line_number, 600 ,RGBh25[24]);

    genvar  i ; 
	 generate
        for ( i = 0; i < 800 ; i = i + 32 ) begin : genblock
            equal U0(pixel_number, i ,RGBv25[(i)/32]);
		  end
    endgenerate 
	 genvar  ii ;
	 	generate
        for ( ii = 32; ii <= 544 ; ii = ii + 32 ) begin : genblock2
				equal U0(line_number, ii ,RGBh25[(ii)/32]);
		  end
     endgenerate
		assign RGBv = |(RGBv25);
		assign RGBh = |(RGBh25);
//     assign RGBpins  =   (RGBv|RGBh) ?  3'b001 : 3'b000 ;
		assign RGBpins[1]  = (RGBv|RGBh) ?  1 : 0 ;
		assign RGBpins[2]  = (line_number == 288)  ?  1 : 0 ;
endmodule 
