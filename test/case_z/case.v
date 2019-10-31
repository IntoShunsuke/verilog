module case_z();

wire [1:0] OUT;
wire [1:0] SEL = 2'bzz;

assign OUT = (SEL == 0) ? 0:
             (SEL == 1) ? 1:
             (SEL == 2'bzz) ? 2:
             3;

initial begin
    $monitor ("OUT = %b", OUT);
end

endmodule