`include "Controller.v"
`include "DataPath.v"

module Mips(
	input clk, reset,
	output [31:0] pc,
	input [31:0] instr,
	output memwrite,
	output [31:0] aluout, writedata,
	input [31:0] readdata
);

wire memtoreg, alusrc, regdst, regwrite, jump, pcsrc, zero;

wire [2:0] alucontrol;

wire [5:0] op = instr[31:26];
wire [5:0] funct = instr[5:0];

Controller controller(op, funct, zero, 
	memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucontrol);

DataPath datapath(clk, reset, memtoreg, pcsrc, alusrc, regdst, regwrite, jump, alucontrol, 
	zero,pc, instr, aluout, writedata, readdata);


endmodule