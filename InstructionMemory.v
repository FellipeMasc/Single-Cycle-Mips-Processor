module InstructionMemory(
	input [5:0] A,
	output [31:0] RD
);

reg [31:0] RAM[17:0];

initial begin
	$readmemh("./memfile.dat",RAM,0,17);
end

assign RD = {{RAM[A]},{RAM[A+32'd1]},{RAM[A+32'd2]},{RAM[A+32'd3]}};

endmodule