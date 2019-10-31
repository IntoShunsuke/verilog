module multi_test;

reg CLK, RST;
reg A, B;
wire O;

// DUT
multi_top multi (CLK, RST, A, B, O);

// clk generator
always #5
    CLK <= ~CLK;

initial begin
    $dumpfile("multi_test.vcd");
    $dumpvars(0, multi_test);
    $monitor ("%t: A = %b, B = %b, O = %b, RST = %b", $time, A, B, O, RST);

         RST = 0; CLK = 0;
    #5   A = 0; B = 0; RST = 1;
    #10  A = 1; B = 1; RST = 0;
    #10  A = 1; B = 1;
    #10  A = 1; B = 1;
    #10  A = 1; B = 1;
    #10
    #10

    #40  $dumpflush;

    #10  $finish;
end

endmodule