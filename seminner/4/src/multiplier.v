module multiplier(CLK, RST, A, B, OA, OB, OC, OD, CTRL_IN_B);

input        CLK, RST;
input        A, B;
input  [2:0] CTRL_IN_B;
output       OA, OB, OC, OD;

reg [3:0] IBUF_A, IBUF_B;

// input A
always@ (posedge CLK or negedge RST) begin
    if(!RST)
        IBUF_A <= 4'b000;
    else begin
        IBUF_A <= {IBUF_A[2], IBUF_A[1], IBUF_A[0], A};
    end
end

// Input B
always@ (posedge CLK or negedge RST) begin
    if (!RST) begin
        IBUF_B <= 4'b0;
    end else begin
        if (!CTRL_IN_B[2]) begin
            IBUF_B[CTRL_IN_B[1:0]] <= B;
        end
    end
end

assign OA = IBUF_A[0] & IBUF_B[0];
assign OB = IBUF_A[1] & IBUF_B[1];
assign OC = IBUF_A[2] & IBUF_B[2];
assign OD = IBUF_A[3] & IBUF_B[3];

endmodule
