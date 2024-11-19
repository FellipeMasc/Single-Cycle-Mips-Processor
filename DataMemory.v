module DataMemory(
	input clk, we,
	input [31:0] a, wd,
	output reg [31:0] rd
);

wire [31:0] RAM[63:0]

assign rd = RAM[a[31:2]];

always @(posedge clk) begin
	if(we) begin
		RAM[a[31:2]] <= wd;
	end
end


endmodule