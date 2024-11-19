`include "MainDecoder.v"
`include "AluDecoder.v"

module Controller(
	input [5:0] op,
	input [5:0] funct,
	input zero,
	output reg memtoreg,
	output reg memwrite,
	output reg pcsrc,
	output reg alusrc,
	output reg regdst,
	output reg regwrite,
	output reg jump,
	output reg [2:0] alucontrol
);

wire [1:0] aluop;
wire branch;

MainDecoder md(op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, aluop);

AluDecoder ad(funct, aluop, alucontrol);

assign pcsrc = branch & zero;

endmodule