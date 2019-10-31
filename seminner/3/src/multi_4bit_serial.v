module multi_4bit_serial(CLK, RST, A, B, O);

input  CLK, RST, A, B;
output O;

reg  [3:0] INPUT_BUF_A, INPUT_BUF_B;
wire [2:0] CTRL_B0, CTRL_B1, CTRL_B2, CTRL_B3;
wire [2:0] CTRL_IN_BUF;
wire       CARRY_IN;
wire       C0, C1;
wire       OP1, OP2, OP3, OP4, OP5;
wire       tmp1, tmp2;
reg        Q1, Q2, Q3;

// Input buffer
always@ (posedge CLK or negedge RST) begin
    if (!RST) begin
        INPUT_BUF_A <= 3'b0;
        INPUT_BUF_B <= 3'b0;
    end else begin
        if (!CTRL_IN_BUF[2]) begin
            INPUT_BUF_A[CTRL_IN_BUF[1:0]] <= A;
            INPUT_BUF_B[CTRL_IN_BUF[1:0]] <= B;
        end
    end
end

// Multiplier
multiplier multiplier (INPUT_BUF_A, INPUT_BUF_B,
                       CTRL_B0, CTRL_B1, CTRL_B2, CTRL_B3,
                       tmp1, OP1, OP2, OP3
                      );

assign OP4 = (CARRY_IN) ? tmp2 : tmp1;

// Population count
populationCount PC ({OP1, OP2, OP3, OP4, OP5}, {C1, C0, O});

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

assign tmp2 = Q3;

// Control-signal generator
ctrl_signal_generator CG (CLK, RST,
                          CTRL_B0, CTRL_B1, CTRL_B2, CTRL_B3,
                          CARRY_IN, CTRL_IN_BUF
                         );



endmodule