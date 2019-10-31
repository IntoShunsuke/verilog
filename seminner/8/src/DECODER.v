module DECODER(NUM, LED);

input      [2:0] NUM;
output reg [6:0] LED;

always@ ( NUM ) begin
    case ( NUM )
        3'd0:       LED = 7'b000_0000;
        3'd1:       LED = 7'b000_1000;
        3'd2:       LED = 7'b010_0010;
        3'd3:       LED = 7'b010_1010;
        3'd4:       LED = 7'b110_0011;
        3'd5:       LED = 7'b110_1011;
        3'd6:       LED = 7'b111_0111;
        default:    LED = 7'bx;
    endcase
end

endmodule