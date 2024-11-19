`include "Controller.v"
`include "DataPath.v"

module MIPS(
	input clk, reset,
	output reg [31:0] pc,
	input [31:0] instr,
	output reg memwrite,
	output reg [31:0] aluout, writedata,
	input [31:0] readdata,
);

wire memtoreg, alusrc, regdst, regwrite, jump, pcsrc, zero;

reg [2:0] alucontrol;

Controller controller(instr[31:26], instr[5:0], zero, 
	memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

DataPath datapath(clk, reset, memtoreg, pcsrc, alusrc, regdst, regwrite, jump, alucontrol, 
	zero,pc, instr, aluout, writedata, readdata);


endmodule