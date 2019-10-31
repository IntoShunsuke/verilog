module aho(CLK, RST, AHO);

input  CLK, RST;
output AHO;

reg [3:0]   cnt_judg;
reg [15:0]  cnt;
wire        FLAG1, FLAG2, FLAG3, FLAG_MAX;


// 16bit count
always@ (posedge CLK or negedge RST) begin
    if (!RST)
        cnt <= 16'h0;
    else begin
        cnt <= cnt + 3'b1;
    end
end

assign FLAG_MAX = &cnt;

// judg count
always@ (posedge CLK or negedge RST) begin
    if (!RST | FLAG_MAX)
        cnt_judg <= 4'b0;
    else if (&cnt_judg)
        cnt_judg <= 4'b1;
    else begin
        cnt_judg <= cnt_judg + 4'b1;
    end
end

populationCount PC(cnt_judg, FLAG1);

assign FLAG2 = cnt_judg[3] & ~cnt_judg[2] & cnt_judg[1] & cnt_judg[0];
assign FLAG3 = cnt_judg[3] & cnt_judg[2] & ~cnt_judg[1] & cnt_judg[0];
assign AHO = ((~|cnt) ? 1'b0 : ~(FLAG1 | FLAG2 | FLAG3));

endmodule

module populationCount(I, O);

    input  [3:0] I;
    output       O;

assign O = (((I[0] + I[1] + I[2] + I[3]) == 2'b01) ? 1'b1 : 1'b0);


endmodule