module count32_2(I, O);

input [31:0] I;
output [5:0] O;

wire [31:0] cnt1, cnt2, cnt3, cnt4, cnt5;

assign cnt1 = (   I & 32'h5555_5555) + ((   I & 32'hAAAA_AAAA) >> 1);
assign cnt2 = (cnt1 & 32'h3333_3333) + ((cnt1 & 32'hCCCC_CCCC) >> 2);
assign cnt3 = (cnt2 & 32'h0F0F_0F0F) + ((cnt2 & 32'hF0F0_F0F0) >> 4);
assign cnt4 = (cnt3 & 32'h00FF_00FF) + ((cnt3 & 32'hFF00_FF00) >> 8);
assign cnt5 = (cnt4 & 32'h0000_FFFF) + ((cnt4 & 32'hFFFF_0000) >> 16);

assign O = cnt5[5:0];

endmodule