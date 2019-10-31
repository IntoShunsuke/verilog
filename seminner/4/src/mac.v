module mac(CLK, RST, A, B, C, O,
           START, READY, END, O_VALID
          );

input  CLK, RST;
input  A, B, C;
output O;
input  START;
output READY, END, O_VALID;

wire O_A, O_B, O_C;
wire O_MULTI, RST_E;
reg  Q;
reg  READY, RST_EN;
wire [1:0] I_VALID; // [1]:C [0]:A,B
reg        STATUS;  // 1:input 0:0
reg  [3:0] cnt;     // stores how many times it has been input.

// inputs VALID
assign {O_A, O_B} = {2{I_VALID[0]}} & {A, B};
assign O_C = I_VALID[1] & C;

// D-FF for input C
// O_MULTI is delayed by 1 clock by the multiplier.
always@ (posedge CLK or negedge RST) begin
    if (!RST) begin
        Q <= 1'b0;
    end else begin
        Q <= O_C;
    end
end

multi_serial multi(.CLK(CLK), .RST(RST_E), .A(O_A), .B(O_B), .O(O_MULTI), .cnt(cnt[2:0]));
adder_serial adder(.CLK(CLK), .RST(RST_E), .A(O_MULTI), .B(Q), .O(O));

// ready signal
always@ (posedge START or posedge END or negedge RST_E) begin
    if (!RST_E)
        READY <= 1'b1;
    else if (START)
        READY <= 1'b0;
    else if (RST_EN)
        READY <= 1'b1;
end

// reset when posedge END
always@ (posedge CLK or negedge RST) begin
    if (!RST)
        RST_EN <= 1'b0;
    else
        RST_EN = END;
end
assign RST_E = (RST_EN) ? 1'b0 : RST;

// O_VALID
assign O_VALID = (4'd0 < cnt && cnt < 4'd10) ? 1'b1: 1'b0;

// END
assign END = (cnt == 4'd9) ? 1'b1 : 1'b0;


// ctrl_signal_generator
always@ (posedge CLK or negedge RST) begin
    if (!RST)
        cnt <= 4'b0;
    else if (READY)
        cnt <= 4'b0;
    else
        cnt <= cnt + 1;
end

// STATUS for input ctrl signal
always@ (START or cnt) begin
    if (START)
        STATUS <= 1'b1;
    else if (cnt[2:0] == 3'b0)
        STATUS <= 1'b0;
end

assign I_VALID[0] = STATUS & ~cnt[2];
assign I_VALID[1] = STATUS;

endmodule