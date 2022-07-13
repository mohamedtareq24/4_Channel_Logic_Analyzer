module H_sync (
    input  clk,         // clk = 40 MHz
    output pulse, finish,display,
    output reg[10:0]  pixel   
);
 // just put the timing http://tinyvga.com/vga-timing
 

always @( posedge clk) begin
    if (pixel < 1056)
        pixel <= pixel + 1 ;
    else
        pixel  <= 0 ;       
  
end

assign pulse   =  (pixel > (800+40) && pixel < (840+128)); // that's the pulse the monitor is looking for 
assign finish  =  (pixel == 1056);
assign display =  (pixel <= 800);  // when it's valid to put a pixel other wise nothing will be displayed 

endmodule //H_sync



