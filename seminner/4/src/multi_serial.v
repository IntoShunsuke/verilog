// input  : 8 bit 2
// output : 8 bit 1
module multi_serial(CLK, RST, A, B, O, cnt);

input        CLK, RST, A, B;
input  [2:0] cnt;
output       O;

wire [2:0] CTRL_IN_B;
wire       CARRY_IN;
wire       C0, C1;
wire       OP1, OP2, OP3, OP4, OP5;
wire       tmp1;
reg        Q1, Q2, Q3;

// Multiplier
multiplier multiplier (.CLK(CLK), .RST(RST), .A(A), .B(B),
                       .OA(tmp1), .OB(OP3), .OC(OP2), .OD(OP1),
                       .CTRL_IN_B(CTRL_IN_B)
                      );

assign OP4 = (CARRY_IN) ? Q3 : tmp1;

// Population count
populationCount PC (.I({OP1, OP2, OP3, OP4, OP5}), .O({C1, C0, O}));

// D-FF for C0
always@ (posedge CLK or negedge RST) begin
    if (!RST)
        Q1 <= 1'b0;
    else
        Q1 <= C0;
end
assign OP5 = Q1;

// D-FF for C1
always@ (posedge CLK or negedge RST) begin
    if (!RST) begin
        Q2 <= 1'b0;
        Q3 <= 1'b0;
    end else begin
        Q2 <= C1;
        Q3 <= Q2;
    end
end

// Control-signal generator
multi_ctrl_signal_gen MCG (.CLK(CLK), .RST(RST), .cnt(cnt),
                           .CARRY_IN(CARRY_IN), .CTRL_IN_B(CTRL_IN_B)
                          );

endmodule