`include "Mips.v"
`include "InstructionMemory.v"
`include "DataMemory.v"

module Top(input clk, reset,
output [31:0] writedata, 
output [31:0] dataadr,
output memwrite);
	wire [31:0] pc, instr, readdata;
	Mips mips (
        .clk(clk),
        .reset(reset),
        .memwrite(memwrite),
				.aluout(dataadr),
        .writedata(writedata),
				.readdata(readdata),
				.pc(pc),
				.instr(instr)
    );
	InstructionMemory imem(.A(pc[7:2]), .RD(instr));
	DataMemory dmem(.clk(clk), .we(memwrite), .a(dataadr), .wd(writedata),
.rd(readdata));
endmodule