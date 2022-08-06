module WA_CTRL (
  input we, 
  input  [15:0] old_address, 
  output [15:0] write_address
);
assign write_address = old_address + we ;
endmodule //WA_CTRL