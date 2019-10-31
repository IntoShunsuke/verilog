module TRIANGLE(A, B, C, OUT);

input  [7:0] A, B, C;
output       OUT;

wire [7:0] MAX, OP1, OP2, COMP1;
wire [8:0] SUM;
wire       FLAG1, FLAG2;

// max value
assign FLAG1 = A > B;
assign FLAG2 = COMP1 > C;
assign COMP1 = FLAG1 ? A : B;
assign OP1 = FLAG1 ? B : A;
assign MAX = FLAG2 ? COMP1 : C;
assign OP2 = FLAG2 ? C : COMP1;

// check
assign SUM = OP1 + OP2;
assign OUT = MAX < SUM;


endmodule