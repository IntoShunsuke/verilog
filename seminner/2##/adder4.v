module adder4(A, B, O);

input  [3:0] A, B;
output [4:0] O;

assign O = A + B;

endmodule