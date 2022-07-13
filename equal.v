module equal (
    input [9:0] in1,
    input [9:0] in2,
    output out
);
assign out = (in1 == in2) ;
endmodule //equal