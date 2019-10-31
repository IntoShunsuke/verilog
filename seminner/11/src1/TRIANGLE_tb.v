`timescale 1ns/1ns
module TRIANGLE_tb;

reg  [7:0] A, B, C;
wire       OUT;

parameter STEP = 10;

// DUT
TRIANGLE DUT (.A(A), .B(B), .C(C), .OUT(OUT));

initial begin
    $dumpfile("TRIANGLE.vcd");
    $dumpvars(0, TRIANGLE_tb);
    $monitor ("%t: A = %d, B = %d, C = %d, OUT = %b", $time, A, B, C, OUT);

            A = 127; B = 255; C = 200;
    #(STEP) A = 3; B = 4; C = 5;
    #(STEP) A = 10; B = 100; C = 255;
    #(STEP) A = 1; B = 1; C = 1;
    #(STEP) A = 1; B = 127; C = 255;
    #(STEP) A = 1; B = 128; C = 127;
    #(STEP) A = 254; B = 127; C = 127;
    #(STEP) A = 127; B = 127; C = 254;
    #(STEP) A = 255; B = 255; C = 255;
    #(STEP)


    #(STEP) $dumpflush;

    #(STEP) $finish;
end

endmodule