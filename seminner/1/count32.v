module count32(I, O);

input [31:0] I;
output [5:0] O;

reg [5:0] cnt, i;

always@ ( I ) begin
    i = 0;
    cnt = 0;
    repeat ( 32 ) begin
        // $monitor ("i = %d, cnt = %d", i, cnt);
        cnt = (I[i] == 1'b1) ? cnt+1 : cnt;
        i = i + 1;
    end
end

assign O = cnt[5:0];

endmodule