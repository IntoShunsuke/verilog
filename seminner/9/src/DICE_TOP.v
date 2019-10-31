module DICE_TOP(CLK, BUTTON_N, LED);

input        CLK;
input        BUTTON_N;
output [6:0] LED;

wire CH_O;
wire START;
reg  D, RST;

initial begin
    RST = 0;
    #(10) RST = 1;
end


// Chattering elimination
CHATTERING CH(.CLK(CLK), .RST(RST), .IN(BUTTON_N), .OUT(CH_O));

// one-shot circuit
always@ ( posedge CLK or negedge RST ) begin
    if ( !RST )
        D <= 0;
    else
        D <= CH_O;
end

assign START = ~CH_O & D;

DICE DICE(.CLK(CLK), .RST(RST), .START(START), .LED(LED));

endmodule


module CHATTERING(CLK, RST, IN, OUT);

input  CLK, RST;
input  IN;
output OUT;

reg         D;
reg  [20:0] CNT;
wire        SIG_EN, OUT;

// divider
always@ ( posedge CLK or negedge RST ) begin
    if ( !RST )
        CNT <= 21'd1249998;
    else if ( SIG_EN )
        CNT <= 21'd1249998;
    else
        CNT <= CNT - 1;
end

assign SIG_EN = !(|CNT);

always@ ( posedge CLK or negedge RST ) begin
    if ( !RST ) begin
        D   <= 0;
    end else if ( SIG_EN ) begin
        D <= IN;
    end
end

assign OUT = D;

endmodule