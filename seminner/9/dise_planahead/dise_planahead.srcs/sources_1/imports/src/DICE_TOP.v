module DICE_TOP(CLK, BUTTON_N, LED);

input        CLK;
input        BUTTON_N;
output [6:0] LED;

wire CH_O;
wire BUTTON, START;
reg  D;
wire RST;

assign RST = 1;

assign BUTTON = ~BUTTON_N;

// Chattering elimination
CHATTERING CH(.CLK(CLK), .RST(RST), .IN(BUTTON), .OUT(CH_O));

// one-shot circuit
always@ ( posedge CLK or negedge RST ) begin
    if ( !RST )
        D <= 0;
    else
        D <= CH_O;
end

assign START = CH_O & ~D;

DICE DICE(.CLK(CLK), .RST(RST), .START(START), .LED(LED));

endmodule


module CHATTERING(CLK, RST, IN, OUT);

input  CLK, RST;
input  IN;
output OUT;

reg         D, OUT;
reg  [20:0] CNT;

// divider
always@ ( posedge CLK or negedge RST ) begin
    if ( !RST )
        CNT <= 21'd1249998;
    else if ( !(|CNT) )
        CNT <= 21'd1249998;
    else
        CNT <= CNT - 1;
end

always@ ( posedge CLK or negedge RST ) begin
    if ( !RST ) begin
        D   <= 0;
        OUT <= 0;
    end else if ( !(|CNT) ) begin
        D   <= IN;
        OUT <= D;
    end
end

endmodule