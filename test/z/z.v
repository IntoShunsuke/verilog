module z();

wire [1:0] O;
reg A, B;

assign O = A + B;

initial begin
    A = 1'b1; B = 1'bz;
    $monitor ("%b", O);
end

endmodule