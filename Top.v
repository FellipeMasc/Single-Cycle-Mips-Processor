`include "Mips.v"
`include "InstructionMemory.v"
`include "DataMemory.v"

module top (input clk, reset,
output [31:0] writedata, dataadr,
output memwrite);
	wire [31:0] pc, instr, readdata;
	Mips mips(clk, reset, pc, instr, memwrite, dataadr,
	writedata, readdata);
	InstructionMemory imem(pc[7:2], instr);
	DataMemory dmem(clk, memwrite, dataadr, writedata,
readdata);
endmodule