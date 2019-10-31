`timescale 1ns/1ns
module mac_test;

reg  CLK, RST;
reg  A, B, C;
wire O;
reg  START;
wire READY, END, O_VALID;

parameter STEP = 10;

// DUT
// mac DUT (.CLK(CLK), .RST(RST), .A(Q[0]), .B(Q[1]), .C(Q[2]), .O(O));
mac DUT (.CLK(CLK), .RST(RST), .A(A), .B(B), .C(C), .O(O),
         .START(START), .READY(READY), .END(END), .O_VALID(O_VALID)
        );

// clk generator
always #(STEP/2)
    CLK <= ~CLK;

initial begin
    $dumpfile("mac_test.vcd");
    $dumpvars(0, mac_test);
    $monitor ("%t: A = %b, B = %b, O = %b, O_VALID = %b, RST = %b", $time, A, B, O, O_VALID, RST);

             RST = 1; CLK = 1; START = 0;
    #(STEP)  A = 0; B = 0; C = 0; RST = 0;
    #(STEP)  RST = 1;

    #(1)     A = 1; B = 1; C = 1; START = 1;
    #(STEP)  A = 1; B = 1; C = 1; START = 0;
    #(STEP)  A = 1; B = 1; C = 1;
    #(STEP)  A = 1; B = 1; C = 1;
    #(STEP)                C = 1;
    #(STEP)                C = 1;
    #(STEP)                C = 1;
    #(STEP)                C = 1;
    #(STEP*10)

    #(STEP)  A = 1; B = 0; C = 1; START = 1;
    #(STEP)  A = 0; B = 1; C = 1; START = 0;
    #(STEP)  A = 1; B = 0; C = 1;
    #(STEP)  A = 0; B = 1; C = 0;
    #(STEP)                C = 1;
    #(STEP)                C = 1;
    #(STEP)                C = 1;
    #(STEP)                C = 0;
    #(STEP*5)
    #(STEP) $dumpflush;

    #(STEP)  $finish;
end

endmodule