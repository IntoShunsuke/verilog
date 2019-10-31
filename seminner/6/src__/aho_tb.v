`timescale 1ns/1ns
module aho_tb;

reg  CLK, RST;
wire AHO;

parameter STEP = 10;

// DUT
aho DUT (.CLK(CLK), .RST(RST), .AHO(AHO));

// clk generator
always #(STEP/2)
    CLK <= ~CLK;

initial begin
    $dumpfile("aho_tb.vcd");
    $dumpvars(0, aho_tb);
    $monitor ("%t: AHO = %b, RST = %b", $time, AHO, RST);

             RST = 1; CLK = 1;
    #(STEP)  RST = 0;
    #(STEP)  RST = 1;
    #(STEP*655400)

    #(STEP) $dumpflush;

    #(STEP) $finish;
end

endmodule