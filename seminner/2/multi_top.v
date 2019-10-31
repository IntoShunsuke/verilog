module multi_top(CLK, RST, A, B, O);

input CLK, RST;
input A, B;
output O;

reg [1:0] cnt_in;
reg [2:0] cnt_out;
reg [3:0] in_bufA, in_bufB;
reg [7:0] out_buf;
reg tmp;

wire bit_0, bit_1, bit_2, bit_3, bit_4, bit_5, bit_6, bit_7;

// input
always@ (posedge CLK) begin
    if (RST) begin
        in_bufA <= 0;
        in_bufB <= 0;
        cnt_in <= 0;
    end else begin
        in_bufA[cnt_in] <= A;
        in_bufB[cnt_in] <= B;
        cnt_in <= cnt_in + 1;
    end
end

assign bit_0 = in_bufA[0] & in_bufB[0];

// output
always@ (posedge CLK) begin
    if (RST) begin
        out_buf <= 0;
        cnt_out <= 3'b110;
    end else begin
        out_buf <= {bit_7, bit_6, bit_5, bit_4, bit_3, bit_2, bit_1, bit_0};
        $display ("out_buf = %b, cnt_out = %b", out_buf, cnt_out);
        tmp <= out_buf[cnt_out];
        cnt_out <= cnt_out + 1;
    end
end

assign O = tmp;

endmodule