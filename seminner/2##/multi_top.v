module multi_top(CLK, RST, A, B, O);

input CLK, RST;
input A, B;
output reg O;

reg [1:0] cnt_in;
reg [2:0] cnt_out;
reg [3:0] in_bufA, in_bufB;
reg [7:0] out_buf;
reg tmp;
wire [3:0] AB0, AB1, AB2, AB3;
wire [4:0] C0, C1, C2;


// input
always@ (posedge CLK or negedge RST) begin
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

// multiplication
assign AB0 = in_bufA & {4{in_bufB[0]}};
assign AB1 = in_bufA & {4{in_bufB[1]}};
assign AB2 = in_bufA & {4{in_bufB[2]}};
assign AB3 = in_bufA & {4{in_bufB[3]}};

adder4 adder_0({1'b0, AB0[3:1]}, AB1, C0);
adder4 adder_1(AB1, C0[4:1], C1);
adder4 adder_2(AB2, C1[4:1], C2);

// output
always@ (posedge CLK or negedge RST) begin
    if (RST) begin
        out_buf <= 0;
        cnt_out <= 3'b110;
    end else begin
        out_buf <= {C2, C1[0], C0[0], AB0[0]};
        // $display ("out_buf = %b, cnt_out = %b", out_buf, cnt_out);
        O <= out_buf[cnt_out];
        cnt_out <= cnt_out + 1;
    end
end

endmodule