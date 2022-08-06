module read_organizer (
    input [3:0] q,
    input [14:0] read_address,
    input [1:0] mode, 
    input [9:0] line_number,
    output reg Q
);

always @(*) begin
    case (mode)
        0:begin
            if (read_address < 8192 & line_number <= 192)
                Q = q[0];
            else if (read_address < 8192*2 & read_address >= 8192 & line_number <=192)
                Q = q[1];    
            else if (read_address < 8192*3 & read_address >= 8192*2 & line_number <=192)
                Q = q[2];
            else if (read_address < 8192*4 & read_address >= 8192*3 & line_number <=192)
                Q = q[3];
				else
					Q = 1'b0;
        end
        1: begin
            if (read_address < 8192 & line_number <= 192)
                Q = q[0];
            else if (read_address >= 8192 & line_number <= 192)
                Q = q[2];                
            else if (read_address < 8192 & line_number > 192 & line_number <= 384)
                Q = q[1];
            else if (read_address >= 8192&line_number > 192 & line_number <= 384)
                Q = q[3];    
            else
                Q = 1'b0;            
        end
        2: begin
            if (line_number <= 192)
                Q = q[0];
            else if (line_number > 192 & line_number <= 384 )
                Q = q[1];
            else if (line_number > 384 & line_number <= 576 ) 
                Q = q[2];
            else if  (line_number > 576)
                Q = q[3];
            else 
                Q = 1'b0;        
        end 
        default: begin
            Q = 1'b0 ; 
        end
    endcase
end

endmodule //read_organizer