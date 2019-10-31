module multi_4bit_serial_test;

reg CLK, RST;
reg A, B;
wire O;

// DUT
multi_4bit_serial DUT (CLK, RST, A, B, O);

// clk generator
always #5
    CLK <= ~CLK;

initial begin
    $dumpfile("multi_test.vcd");
    $dumpvars(0, DUT);
    $monitor ("%t: A = %b, B = %b, O = %b, RST = %b", $time, A, B, O, RST);

         RST = 1; CLK = 0;
    #10  A = 0; B = 0; RST = 0;
    #10  A = 1; B = 1; RST = 1;
    #10  A = 1; B = 1;
    #10  A = 1; B = 1;
    #10  A = 1; B = 1;

    #30

    #40  $dumpflush;

    #10  $finish;
end

endmodule