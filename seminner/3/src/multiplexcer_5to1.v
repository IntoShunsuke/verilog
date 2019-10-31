module multiplexcer_5to1(A, B, C, D, E, SEL, O);

input        A, B, C, D, E;
input  [2:0] SEL;
output       O;

assign O = (SEL == 3'b000) ? A:
           (SEL == 3'b001) ? B:
           (SEL == 3'b010) ? C:
           (SEL == 3'b011) ? D:
           E;

endmodule