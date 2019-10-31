`timescale 1ns/1ns
module adder_serial_test;

reg CLK, RST;
reg A, B;
wire O;

parameter STEP = 10; // 1 cycle 10 ns

// DUT
adder_serial DUT (.CLK(CLK), .RST(RST), .A(Q[0]), .B(Q[1]), .O(O));

// clk generator
always #(STEP/2)
    CLK <= ~CLK;

// D-FF for inputs
reg [1:0] Q;
always@ (posedge CLK or negedge RST) begin
    if (!RST) begin
        Q <= 2'b0;
    end else begin
        Q[0] <= A;
        Q[1] <= B;
    end
end

initial begin
    $dumpfile("adder_serial_test.vcd");
    $dumpvars(0, adder_serial_test);
    $monitor ("%t: A = %b, B = %b, O = %b, RST = %b", $time, A, B, O, RST);

          RST = 1; CLK = 0;
    #(STEP/2)
    #STEP A = 0; B = 0; RST = 0;
    #STEP A = 1; B = 1; RST = 1;
    #STEP A = 1; B = 1;

    #(STEP*4) $dumpflush;

    #STEP     $finish;
end

endmodule