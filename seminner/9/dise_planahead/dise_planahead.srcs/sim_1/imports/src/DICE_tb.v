`timescale 1ns/100ps
module DICE_tb;

reg        CLK, RST, BUTTON_N;
wire [6:0] LED;

parameter STEP = 10;

// DUT
DICE_TOP DUT (.CLK(CLK), .RST(RST), .BUTTON_N(BUTTON_N), .LED(LED));

// clk generator
initial
    CLK = 1;

always #(STEP/2)
    CLK <= ~CLK;

initial begin
    $dumpfile("DICE.vcd");
    $dumpvars(0, DICE_tb);
    $monitor ("%t: BUTTON_N = %b, LED = %b", $time, BUTTON_N, LED);

                RST = 0; BUTTON_N = 1;
    #(STEP)  RST = 1;
    #(STEP*10) BUTTON_N = 0;
    #(STEP*140000) BUTTON_N = 1;


    #(STEP) $dumpflush;

    #(STEP) $finish;
end

endmodule