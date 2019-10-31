module ctrl_signal_generator(CLK, RST,
                             CARRY_IN, CTRL_IN_A, CTRL_IN_B
                            );

input        CLK, RST;
output       CARRY_IN, CTRL_IN_A;
output [2:0] CTRL_IN_B;

reg [2:0] status; //stores the number of bits currently being calculated

always@ (posedge CLK or negedge RST) begin
    if(!RST)
        status = 3'b111;
    else
        status = status + 1'b1;
end

// Carry
function DEC_CARRY;
    input [2:0] DECIN;
    begin
        case(DECIN)
            3'b0:      DEC_CARRY = 1'b0;
            3'h1:      DEC_CARRY = 1'b0;
            3'h2:      DEC_CARRY = 1'b0;
            3'h3:      DEC_CARRY = 1'b0;
            default:   DEC_CARRY = 1'b1;
        endcase
    end
endfunction

//ctrl_in_A
function DEC_IN_A;
    input [2:0] DECIN;
    begin
        case(DECIN)
            3'b000 :   DEC_IN_A = 1'b1;
            3'b001 :   DEC_IN_A = 1'b1;
            3'b010 :   DEC_IN_A = 1'b1;
            3'b011 :   DEC_IN_A = 1'b1;
            default:   DEC_IN_A = 1'b0;
        endcase
    end
endfunction

// ctrl_in_B
assign CTRL_IN_B = status + 2'h1;

assign CTRL_IN_A = DEC_IN_A(status);
assign CARRY_IN = DEC_CARRY(status);

endmodule