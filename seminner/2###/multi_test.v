`timescale 1ns/1ns

module multi_test;

reg CLK = 0, RST = 0;
reg A, B, VALID;
wire O;

// DUT
multi_top multi (CLK, RST, VALID, A, B, O);

// clk generator
always #5
    CLK <= ~CLK;

initial begin
    $dumpfile("multi_test.vcd");
    $dumpvars(0, multi_test);
    $monitor ("%t: A = %b, B = %b, O = %b, RST = %b", $time, A, B, O, RST);

    #5   RST = 1; VALID = 0;
    #10  A = 1; B = 1; RST = 0; VALID = 1;
    #10  A = 1; B = 1;
    #10  A = 1; B = 1;
    #10  A = 1; B = 1;
    #10  VALID = 0;
    #30

    #40  $dumpflush;

    #10  $finish;
end

endmodule