module multiplier(IA, IB,
                  CTRL_B0, CTRL_B1, CTRL_B2, CTRL_B3,
                  OA, OB, OC, OD
                 );

input  [3:0] IA, IB;
input  [2:0] CTRL_B0, CTRL_B1, CTRL_B2, CTRL_B3;
output       OA, OB, OC, OD;


wire B0, B1, B2, B3;

multiplexcer_5to1 multiplexcer1(IA[0], IA[1], IA[2], IA[3], 1'b0, CTRL_B0, B0);
multiplexcer_5to1 multiplexcer2(IA[0], IA[1], IA[2], IA[3], 1'b0, CTRL_B1, B1);
multiplexcer_5to1 multiplexcer3(IA[0], IA[1], IA[2], IA[3], 1'b0, CTRL_B2, B2);
multiplexcer_5to1 multiplexcer4(IA[0], IA[1], IA[2], IA[3], 1'b0, CTRL_B3, B3);

assign OA = B0 & IB[0];
assign OB = B1 & IB[1];
assign OC = B2 & IB[2];
assign OD = B3 & IB[3];

endmodule