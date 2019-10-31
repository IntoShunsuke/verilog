module shift_register(CLK, RST, A, Q1, Q2, Q3);

input      CLK, RST;
input      A;
output reg Q1, Q2, Q3;

always@ (posedge CLK or negedge RST) begin
    if(!RST)
        {Q3, Q2, Q1} <= 3'b000;
    else begin
        {Q3, Q2, Q1} <= {Q2, Q1, A};
    end
end

endmodule