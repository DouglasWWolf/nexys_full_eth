
module reset_extender # (parameter RESET_CYCLES = 1000)
(
    input clk, resetn,

    output resetn_out
);

reg[15:0] counter = 0;
wire reset_out = (counter != 0);
assign resetn_out = ~reset_out;

always @(posedge clk) begin
    if (resetn == 0)
        counter <= RESET_CYCLES;
    else if (counter)
        counter <= counter - 1;
end


endmodule
