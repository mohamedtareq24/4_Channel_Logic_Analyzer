module edge_det (
    input clk ,data,reset,write_finish,
    output we    
 );
	localparam A = 0 , B = 1, C = 2, D = 3 ,E = 4;
	reg[2:0] state;
	always @(posedge clk)
	begin
		if (reset) 
			state <= A;
		else	
			case (state)
				A : state <= (data) ? B : C ;
				B : state <= (data) ? B : D ;
				C : state <= (data) ? D : C ; 
				D:  state <= (write_finish)? E : D ;
			endcase
	end  
	assign we = (state == D) ;
	initial begin
		state = 0 ;
	end	
endmodule //edge_det