module count32_test;

reg [31:0] I;
wire [5:0] O;

count32 count32 (I, O);
// count32_2 count32(I, O);

initial begin
    $dumpfile("count32_test.vcd");
    $dumpvars(0, count32_test);
    $monitor ("%t: I = %b, out = %b", $time, I, O);

         I = 32'b0;
    #10  I = 32'b1;
    #10  I = 32'hffff_ffff;
    #10  I = 32'hffff_0000;
    #10  I = 32'b0;

    #10  $dumpflush;

    #10  $finish;
end

endmodule