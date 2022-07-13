module register (
    input read ,clk ,
    input [8:0] Data_in,
    output  [8:0]  Data_out   
    );
    reg [8:0] memo [1:0] ;
    initial 
    begin
     memo[0] = 9'b0;
     memo[1] = 9'b0;
    end

	 always @( posedge clk) 
    begin
        memo[~read] = Data_in ;
    end
	assign Data_out = memo[read];
endmodule //register