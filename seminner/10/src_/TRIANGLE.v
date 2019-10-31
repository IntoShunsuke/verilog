module TRIANGLE(A, B, C, OUT);

input  [7:0] A, B, C;
output       OUT;

wire    FLAG1, FLAG2, FLAG3;

assign FLAG1 = {1'b0, A} < (B + C);
assign FLAG2 = {1'b0, B} < (A + C);
assign FLAG3 = {1'b0, C} < (A + B);

assign OUT = FLAG1 & FLAG2 & FLAG3;


endmodule
