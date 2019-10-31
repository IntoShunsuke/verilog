module multiplier(CLK, RST, A, B, OA, OB, OC, OD);

input        CLK, RST;
input        A;
input  [3:0] B;
output       OA, OB, OC, OD;

wire IN_B0, IN_B1, IN_B2, IN_B3;

shift_register SR(CLK, RST, A, IN_B1, IN_B2, IN_B3);

assign IN_B0 = A;

assign OA = IN_B0 & B[0];
assign OB = IN_B1 & B[1];
assign OC = IN_B2 & B[2];
assign OD = IN_B3 & B[3];

endmodule