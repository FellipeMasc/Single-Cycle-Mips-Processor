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


Controller controller(.op(instr[31:26]), .funct(instr[5:0]), .zero(zero), 
	.memtoreg(memtoreg), .memwrite(memwrite), .pcsrc(pcsrc), .alusrc(alusrc), .regdst(regdst), .regwrite(regwrite), .jump(jump), .alucontrol(alucontrol));

DataPath datapath(.clk(clk), .reset(reset), .memtoreg(memtoreg), .pcsrc(pcsrc), .alusrc(alusrc), .regdst(regdst), .regwrite(regwrite), .jump(jump), .alucontrol(alucontrol), .zero(zero), .pc(pc), .instr(instr), .aluout(aluout), .writedata(writedata), .readdata(readdata));

initial begin
	$display("alucontrol: %b", alucontrol);
end


endmodule