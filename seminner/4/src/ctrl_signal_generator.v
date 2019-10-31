module multi_ctrl_signal_gen(CLK, RST, cnt,
                             CARRY_IN, CTRL_IN_A, CTRL_IN_B
                            );

input        CLK, RST;
input  [2:0] cnt;
output       CARRY_IN, CTRL_IN_A;
output [2:0] CTRL_IN_B;

wire [2:0] status; //stores the number of bits currently being calculated

assign status = cnt - 1'b1;

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

// ctrl_in_B
assign CTRL_IN_B = status + 2'h1;

assign CARRY_IN = DEC_CARRY(status);

endmodule