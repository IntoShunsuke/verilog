module TRIANGLE(A, B, C, OUT);

input  [7:0] A, B, C;
output       OUT;

wire [7:0] MAX, OP1, OP2;
wire [8:0] SUM;

// max value
assign MAX = (A > B) ? ((A > C) ? A : C) : ((B > C) ? B : C);
assign OP1 = (MAX == A) ? C : A;
assign OP2 = (MAX == B) ? C : B;

assign SUM = OP1 + OP2;
assign OUT = ({1'b0, MAX} < SUM);


endmodule