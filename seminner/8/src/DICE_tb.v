`timescale 1ns/100ps
module DICE_tb;

reg        CLK, RST, START;
reg  [7:0] I;
wire [3:0] O;

parameter STEP = 10;

// DUT
DICE DUT (.CLK(CLK), .RST(RST), .START(START), .LED(LED));

// clk generator
initial
    CLK = 1;

always #(STEP/2)
    CLK <= ~CLK;

initial begin
    $dumpfile("DICE.vcd");
    $dumpvars(0, DICE_tb);
    $monitor ("%t: START = %b, LED = %b", $time, START, LED);

             RST = 0; START = 0;
    #(STEP)  RST = 1;
    #(STEP*3)  START = 1;
    #(STEP*14) START = 0;
    #(STEP)  START = 1; RST = 1;
    #(STEP) START = 0;


    #(STEP) $dumpflush;

    #(STEP) $finish;
end

endmodule