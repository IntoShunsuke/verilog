// 8bit 2 inputs, 9bit output
module adder_serial(CLK, RST, A, B, O);

input  CLK, RST;
input  A, B;
output O;

wire CARRY;
reg  Q;

assign {CARRY, O} = A + B + Q;

// D-FF for Carry
always@ (posedge CLK or negedge RST) begin
    if (!RST)
        Q <= 1'b0;
    else
        Q <= CARRY;
end

endmodule