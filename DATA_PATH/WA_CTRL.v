module WA_CTRL (
  input clk ,we, 
  input  [13:0] old_address, 
  output [13:0] write_address
);
assign write_address = old_address + we ;
endmodule //WA_CTRL