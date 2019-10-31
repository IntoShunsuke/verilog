module ctrl_signal_generator(CLK, RST,
                             CTRL_B0, CTRL_B1, CTRL_B2, CTRL_B3,
                             CARRY_IN, CTRL_IN_BUF
                            );

input        CLK, RST;
output [2:0] CTRL_B0, CTRL_B1, CTRL_B2, CTRL_B3;
output       CARRY_IN;
output [2:0] CTRL_IN_BUF;

reg [2:0] status; //stores the number of bits currently being calculated

always@ (posedge CLK or negedge RST) begin
    if(!RST)
        status = 3'b110;
    else
        status = status + 1'b1;
end

// ctrl_B0
function [2:0] DEC_B0;
    input [2:0] DECIN;
    begin
        case (DECIN)
            3'h0:      DEC_B0 = 3'h0;
            3'h1:      DEC_B0 = 3'h1;
            3'h2:      DEC_B0 = 3'h2;
            3'h3:      DEC_B0 = 3'h3;
            default:   DEC_B0 = 3'h7;
        endcase
    end
endfunction

// ctrl_B1
function [2:0] DEC_B1;
    input [2:0] DECIN;
    begin
        case(DECIN)
            3'h1:      DEC_B1 = 3'h0;
            3'h2:      DEC_B1 = 3'h1;
            3'h3:      DEC_B1 = 3'h2;
            3'h4:      DEC_B1 = 3'h3;
            default:   DEC_B1 = 3'h7;
        endcase
    end
endfunction

// ctrl_B2
function [2:0] DEC_B2;
    input [2:0] DECIN;
    begin
        case(DECIN)
            3'h2:      DEC_B2 = 3'h0;
            3'h3:      DEC_B2 = 3'h1;
            3'h4:      DEC_B2 = 3'h2;
            3'h5:      DEC_B2 = 3'h3;
            default:   DEC_B2 = 3'h7;
        endcase
    end
endfunction

// ctrl_B3
function [2:0] DEC_B3;
    input [2:0] DECIN;
    begin
        case(DECIN)
            3'h3:      DEC_B3 = 3'h0;
            3'h4:      DEC_B3 = 3'h1;
            3'h5:      DEC_B3 = 3'h2;
            3'h6:      DEC_B3 = 3'h3;
            default:   DEC_B3 = 3'h7;
        endcase
    end
endfunction

// Carry
function DEC_CARRY;
    input [2:0] DECIN;
    begin
        case(DECIN)
            3'h0:      DEC_CARRY = 1'b0;
            3'h1:      DEC_CARRY = 1'b0;
            3'h2:      DEC_CARRY = 1'b0;
            3'h3:      DEC_CARRY = 1'b0;
            default:   DEC_CARRY = 1'b1;
        endcase
    end
endfunction

// ctrl_in_buf
assign CTRL_IN_BUF = status + 2'h2;

assign CTRL_B0  = DEC_B0(status);
assign CTRL_B1  = DEC_B1(status);
assign CTRL_B2  = DEC_B2(status);
assign CTRL_B3  = DEC_B3(status);
assign CARRY_IN = DEC_CARRY(status);

endmodule