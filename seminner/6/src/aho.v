module aho(CLK, RST, AHO);

input  CLK, RST;
output AHO;

reg [1:0]   cnt3;
reg [2:0]   cnt5, cnt7;
reg [15:0]  cnt;
wire        FLAG1, FLAG2, FLAG3, FLAG_MAX;


// 16bit count
always@ (posedge CLK or negedge RST) begin
    if (!RST | FLAG_MAX)
        cnt <= 16'h0;
    else begin
        cnt <= cnt + 3'b1;
    end
end

assign FLAG_MAX = (cnt == 16'hFFFF);

// judge cnt
always@ (posedge CLK or negedge RST) begin
    if (!RST | FLAG_MAX) begin
        cnt3 <= 2'b0;
        cnt5 <= 3'b0;
        cnt7 <= 3'b0;
    end else begin
        cnt3 <= ((FLAG1) ? 2'b1 : cnt3 + 2'b1 );
        cnt5 <= ((FLAG2) ? 3'b1 : cnt5 + 3'b1 );
        cnt7 <= ((FLAG3) ? 3'b1 : cnt7 + 3'b1 );
    end
end

assign FLAG1 = cnt3[0] & cnt3[1];
assign FLAG2 = (cnt5 == 3'b101);
assign FLAG3 = cnt7[0] & cnt7[1] & cnt7[2];
assign AHO = FLAG1 | FLAG2 | FLAG3;

endmodule