/*
module RNG(CLK, RST, START, NUM);

input        CLK, RST;
input        START;
output [2:0] NUM;

reg [2:0] CNT;

always@ ( posedge CLK or negedge RST ) begin
    if ( !RST )
        CNT <= 0;
    else if ( CNT[2] & CNT[0] )
        CNT <= 0;
    else
        CNT <= CNT + 1;
end

assign NUM = {3{START}} & CNT+1;

endmodule
*/

module RNG(CLK, RST, START, NUM);

input            CLK, RST;
input            START;
output reg [2:0] NUM;

reg [2:0] CNT;

always@ ( posedge CLK or negedge RST ) begin
    if ( !RST )
        CNT <= 0;
    else if ( CNT[2] & CNT[0] )
        CNT <= 0;
    else
        CNT <= CNT + 1'b1;
end

always@ ( posedge CLK or negedge RST ) begin
    if ( !RST )
        NUM <= 0;
    else if ( START )
        NUM <= CNT + 1;
end

endmodule