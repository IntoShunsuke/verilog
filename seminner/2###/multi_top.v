module multi_top(CLK, RST, IE, A, B, O);

input CLK, RST, IE;
input A, B;
output reg O;

reg [1:0] cnt_in;
reg [2:0] cnt_out;
reg [3:0] in_bufA, in_bufB;
reg [7:0] out_buf;
reg tmp;
wire [3:0] AB0, AB1, AB2, AB3;
wire [4:0] C0, C1, C2;

reg  BUSY;
wire START, FINISH;

assign START  = (!BUSY & IE) ? 1 : 0;
// assign FINISH = (BUSY & cnt_out == 3'b111) ? 1 : 0;

//busy flag
always@ (posedge CLK) begin
    if (RST) begin
        BUSY <= 0;
    end else if (START) begin
        BUSY <= 1;
        //$display("time:%t, start:%b, busy:%b, ie:%b", $time, START, BUSY, IE);
    end else if (FINISH) begin
        BUSY <= 0;
    end
end

// input bit counter
always@ (posedge CLK) begin
    if(RST) begin
        cnt_in <= 0;
    end else if(START) begin
        cnt_in <= 2'b01;
    end else begin
        cnt_in <= cnt_in + 1;
    end
end

// output bit counter
always@ (posedge CLK) begin
    if(RST) begin
        cnt_out <= 3'b110;
    end else if(START) begin
        cnt_out <= 3'b110;
    end else if(BUSY) begin
        cnt_out <= cnt_out + 1;
    end
end

// input
always@ (posedge CLK) begin
    if (RST) begin
        in_bufA <= 0;
        in_bufB <= 0;
    end else if (IE) begin
        in_bufA[cnt_in] <= A;
        in_bufB[cnt_in] <= B;
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
always@ (posedge CLK) begin
    if (RST) begin
        out_buf <= 0;
    end else begin
        out_buf <= {C2, C1[0], C0[0], AB0[0]};
        // $display ("out_buf = %b, cnt_out = %b", out_buf, cnt_out);
        O <= out_buf[cnt_out];
    end
end

endmodule