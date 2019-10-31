module DICE(CLK, RST, START, LED);

input        CLK, RST;
input        START;
output [6:0] LED;

wire [2:0] NUM;

RNG     RNG(.CLK(CLK), .RST(RST), .START(START), .NUM(NUM));
DECODER DEC(.NUM(NUM), .LED(LED));




endmodule