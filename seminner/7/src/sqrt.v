module sqrt(I, O);

input  [7:0] I;
output [3:0] O;

wire [3:0] C1, C2, C3, C4;          // borrow flag
wire [3:0] CC1, CC2, CC3, CC4;

sqrt_part sq1(.I({4'b0, I[7:6]}), .A(4'b0), .O(O[3]), .C(C1), .CC(CC1));
sqrt_part sq2(.I({C1, I[5:4]}), .A(CC1), .O(O[2]), .C(C2), .CC(CC2));
sqrt_part sq3(.I({C2, I[3:2]}), .A(CC2), .O(O[1]), .C(C3), .CC(CC3));
sqrt_part sq4(.I({C3, I[1:0]}), .A(CC3), .O(O[0]), .C(C4), .CC(CC4));

endmodule


module sqrt_part(I, A, O, C, CC);

input  [5:0] I;
input  [3:0] A;
output       O;
output [3:0] C;
output [3:0] CC;

wire [6:0] S;

// bitの調節して
assign S = I - {1'b0, A, 1'b1};
assign C = (S[6] ? I : S[4:0]);
assign O = ~S[6];
assign CC = {A, O} + O;

endmodule