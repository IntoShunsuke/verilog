module TRIANGLE(
    input [7:0] A, B, C,
    output OUT
);

/*
wire [7:0] LONGER;
wire [7:0] SHORTER;
wire [8:0] COMPERSION_1;
wire [8:0] COMPERSION_2;
wire [8:0] ABS_1, ABS_2;

assign LONGER = ((A>B) ? A : (B>A) ? B : A);
assign SHORTER = ((A<B) ? A : (B<A) ? B : A);

assign COMPERSION_1 = LONGER - C;
assign ABS_1 = ~COMPERSION_1 + 1;
assign COMPERSION_2 = ABS_1[7:0] - SHORTER;
assign ABS_2 = ~COMPERSION_2 + 1;
assign OUT = ( ABS_2[8] == 1 ? 0 : 1 );
*/

wire [7:0] LONGER;
wire [7:0] SHORTER;
wire [8:0] COMP_1, COMP_2;
wire [8:0] ABS_1;
wire       FLAG, TMP;

assign FLAG = A > B;
assign LONGER  = FLAG ? A : B;
assign SHORTER = FLAG ? B : A;
assign COMP_1 = LONGER - C;

assign TMP = COMP_1 ^ {9{COMP_1[8]}};
assign ABS_1 = TMP + COMP_1[8];
assign COMP_2 = ABS_1[7:0] - SHORTER;
assign OUT = COMP_2[8] | !(|COMP_2);


endmodule