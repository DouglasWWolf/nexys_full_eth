
module axis_plug # (DW=32)
(
    input clk,

    output reg          axis_tvalid,
    output reg [DW-1:0] axis_tdata
);

always @(posedge clk) begin
    axis_tvalid <= 0;
    axis_tdata  <= 0;
end

endmodule