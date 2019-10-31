`timescale 1ns/1ns
module sqrt_tb;

reg  [7:0] I;
wire [3:0] O;

parameter STEP = 10;

// DUT
sqrt DUT (.I(I), .O(O));

initial begin
    $dumpfile("sqrt_tb.vcd");
    $dumpvars(0, sqrt_tb);
    $monitor ("%t: I = %d, O = %d", $time, I, O);

             I = 8'd0;
    #(STEP)  I = 8'd56;
    #(STEP)  I = 8'd4;
    #(STEP)  I = 8'd9;


    #(STEP) $dumpflush;

    #(STEP) $finish;
end

endmodule