module sqrt_odd(I, O);

input  [7:0] I;
output [3:0] O;

wire [14:0] FLAG;
wire [7:0]  O1, O2, O3, O4, O5, O6, O7, O8, O9, O10, O11, O12, O13, O14, O15;

sub_odd #(.SUB_VALUE(1)) s1(.I(I), .O(O1), .FLAG(FLAG[0]));
sub_odd #(.SUB_VALUE(3)) s2(.I(O1), .O(O2), .FLAG(FLAG[1]));
sub_odd #(.SUB_VALUE(5)) s3(.I(O2), .O(O3), .FLAG(FLAG[2]));
sub_odd #(.SUB_VALUE(7)) s4(.I(O3), .O(O4), .FLAG(FLAG[3]));
sub_odd #(.SUB_VALUE(9)) s5(.I(O4), .O(O5), .FLAG(FLAG[4]));
sub_odd #(.SUB_VALUE(11)) s6(.I(O5), .O(O6), .FLAG(FLAG[5]));
sub_odd #(.SUB_VALUE(13)) s7(.I(O6), .O(O7), .FLAG(FLAG[6]));
sub_odd #(.SUB_VALUE(15)) s8(.I(O7), .O(O8), .FLAG(FLAG[7]));
sub_odd #(.SUB_VALUE(17)) s9(.I(O8), .O(O9), .FLAG(FLAG[8]));
sub_odd #(.SUB_VALUE(19)) s10(.I(O9), .O(O10), .FLAG(FLAG[9]));
sub_odd #(.SUB_VALUE(21)) s11(.I(O10), .O(O11), .FLAG(FLAG[10]));
sub_odd #(.SUB_VALUE(23)) s12(.I(O11), .O(O12), .FLAG(FLAG[11]));
sub_odd #(.SUB_VALUE(25)) s13(.I(O12), .O(O13), .FLAG(FLAG[12]));
sub_odd #(.SUB_VALUE(27)) s14(.I(O13), .O(O14), .FLAG(FLAG[13]));
sub_odd #(.SUB_VALUE(29)) s15(.I(O14), .O(O15), .FLAG(FLAG[14]));

population_count PC(.I(FLAG), .O(O));

endmodule


module sub_odd(I, O, FLAG);

parameter   SUB_VALUE = 1;

input  [7:0] I;
output [7:0] O;
output       FLAG;

wire [7:0] SUB;
wire       C;

assign {C, SUB} = I - SUB_VALUE;
assign O = ( C ) ? 8'b0 : SUB;
assign FLAG = ~C;

endmodule


module population_count(I, O);

input  [14:0] I;
output [3:0]  O;

wire [15:0] CNT1, CNT2, CNT3, CNT4;

assign CNT1 = (   I & 16'h5555) + ((   I & 16'hAAAA) >> 1);
assign CNT2 = (CNT1 & 16'h3333) + ((CNT1 & 16'hCCCC) >> 2);
assign CNT3 = (CNT2 & 16'h0F0F) + ((CNT2 & 16'hF0F0) >> 4);
assign CNT4 = (CNT3 & 16'h00FF) + ((CNT3 & 16'hFF00) >> 8);

assign O = CNT4[3:0];

endmodule
