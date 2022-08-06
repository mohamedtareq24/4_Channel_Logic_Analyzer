module display_FSM ( // mealy 
    input clk , reset ,
    input [1:0] line_equal_memo_out ,
    output  reg RGB  //RGB controller 
);
    localparam A = 0 ,B = 1 , C = 2 , D = 3 , E = 4 ;
    reg [2:0]old_state , new_state ;
    always @(*)         // states and transitions 
        case (old_state) 
            A : 
                if (line_equal_memo_out == 2'b11) begin
                    new_state = B ; RGB = 1 ;
                end
                else if (line_equal_memo_out == 2'b10) begin
                    new_state = B ; RGB = 0 ;
                end
                else  begin
                new_state = A ; RGB = 0 ;
                end
            B : 
            if (line_equal_memo_out == 2'b01) begin
                    new_state = C ; RGB = 1 ;
                end
                else if (line_equal_memo_out == 2'b00) begin
                    new_state = D ; RGB = 0 ;
                end
                else if (line_equal_memo_out == 2'b11)  begin
                    new_state = B ; RGB = 1 ;
                end
                else begin
                    new_state = B ; RGB = 0 ;
                end        
            C : 
            if (line_equal_memo_out == 2'b01) begin
                    new_state = C ; RGB = 0 ;
                end
                else if (line_equal_memo_out == 2'b00) begin
                    new_state = D ; RGB = 1 ;
                end
                else if (line_equal_memo_out == 2'b10)  begin
                    new_state = E ; RGB = 1 ;
                end
                else begin
                    new_state = E ; RGB = 0 ;
                end              
            
            D : 
            if (line_equal_memo_out == 2'b00) begin
                    new_state = D ; RGB = 0 ;
                end
                else if (line_equal_memo_out == 2'b01) begin
                    new_state = C ; RGB = 1 ;
                end
                else if (line_equal_memo_out == 2'b10)  begin
                    new_state = E ; RGB = 1 ;
                end
                else begin
                    new_state = E ; RGB = 0 ;
                end              
            
            E : 
            if (line_equal_memo_out == 2'b00) begin
                    new_state = A ; RGB = 0 ;
                end
                else if (line_equal_memo_out == 2'b01) begin
                    new_state = A ; RGB = 0 ;
                end
                else if (line_equal_memo_out == 2'b10)  begin
                    new_state = E ; RGB = 1 ;
                end
                else begin
                    new_state = E ; RGB = 0 ;
                end                           
        endcase  
    always @(posedge clk ) begin // state update 
        if (reset)
				old_state <= A ;
        else old_state <= new_state ;     

    end

endmodule //display_FSM

