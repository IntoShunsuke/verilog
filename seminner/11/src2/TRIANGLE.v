module TRIANGLE(
    input [7:0] A, B, C,
    output OUT
);

/*
wire [7:0] LONGER;
wire [7:0] SHORTER;
wire [8:0] COMP_1, COMP_2;
wire [8:0] ABS_1;
wire       FLAG;

assign FLAG = A > B;
assign LONGER  = FLAG ? A : B;
assign SHORTER = FLAG ? B : A;
assign COMP_1 = LONGER - C;
assign ABS_1 = COMP_1[8] ? ~COMP_1 + 1 : COMP_1;
assign COMP_2 = ABS_1[7:0] - SHORTER;
assign OUT = COMP_2[8];
*/

wire [7:0] LONGER, SHORTER;
wire [8:0] D, E, SUB;
wire       FLAG;

assign FLAG = A > B;
assign LONGER  = FLAG ? A : B;
assign SHORTER = FLAG ? B : A;
assign D = LONGER - C;

assign E = {1'b0, SHORTER} ^ {9{!D[8]}};
assign SUB = D + E + !D[8];
assign OUT = SUB[8] ^ D[8] | !{|SUB};

endmodule