`timescale 1ps/1ps
module registerDUT ();
    integer  pixel ;
    reg  clk,read ;
    wire [8:0] Data_out;
    reg [8:0]  Data_in;
    register REGISTER (read ,clk,Data_in,Data_out);
    always
    begin
    #50 clk  = ~clk ;   
    end
     always
    begin
    #100 read  = ~read ;   
    end
    initial begin
         read = 1;
         Data_in = 0 ;
        for ( pixel = 1 ; pixel <= 800; pixel = pixel + 1 )
         begin
            #100 Data_in <= pixel ;
         end
         $stop ;
    end

endmodule //registerDUT