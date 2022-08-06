module write_organizer (
    input  [1:0] mode ,
    input  [3:0]data_source,
    input  [15:0] write_address,
    output reg[3:0] WE,datain
);

always @(*) begin
    case (mode)
        0 : begin                                    /// single channel 
            
            if (write_address >= 8192*4) 
                begin
                    WE = 4'b0 ;
                    datain[3:0] = 0;
                end 
            else if (write_address < 8192)   
                begin
                    WE = 4'b1 ;
                    datain[3:0] = {3'b0,data_source[0]};
                end 

            else if (write_address < 8192*2 & write_address >= 8192)
                begin   
                datain[3:0] = {2'b0,data_source[0],1'b0};
                WE = 4'b10 ;
                end
            else if (write_address < 8192*3 & write_address >= 8192*2)
                begin   
                datain[3:0] = {1'b0,data_source[0],2'b0};
                WE = 4'b100 ;
                end
            else 
                begin   
                datain[3:0] = {data_source[0],3'b0};
                WE = 4'b1000 ;
                end
        end

        1 : begin                       /// dual channel
            

            if (write_address >= 8192*2) 
                WE = 4'b0;            
            if (write_address < 8192)
                WE = 4'b11;
            else 
                WE = 4'b1100; 
            datain[1:0] = data_source[1:0];
            datain[3:2] = data_source[1:0];
        end
         
        2: begin                               // multi channel
            WE = 4'b1111;
            datain = data_source ;
        end
        default : begin
            WE = 4'b0;
            datain = data_source ;
        end
                 
    endcase
end
initial
	begin
		WE = 0;
		datain = 0;
	end
endmodule //write_organizer