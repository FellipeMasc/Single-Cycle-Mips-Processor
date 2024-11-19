`include "Flopr.v"
`include  "Adder.v"
`include "Mux2_1.v"
`include "Sl2.v"
`include "RegisterFile.v"
`include "Alu.v"

module DataPath(
	input clk, reset,
	input memtoreg, pcsrc, 
	input alusrc, regdst, 
	input regwrite, jump, 
	input [2:0] alucontrol,
	output zero,
	output [31:0] pc, 
	input [31:0] instr, 
	output [31:0] aluout, writedata,
	input [31:0] readdata
);

wire [4:0] writereg;
wire [31:0] pcnext, pcnextbr, pcplus4, pcbranch;
wire [31:0] signimm, signimmsh;
wire [31:0] srca, srcb;
wire [31:0] result;

//Next PC logic
Flopr#(32) pcreg(.clk(clk), .rst(reset), .d(pcnext), .q(pc));
Adder pcadd1(.a(pc), .b(32'b100), .y(pcplus4));
Sl2 immsh(.a(signimm), .y(signimmsh));
Adder pcadd2(.a(pcplus4), .b(signimmsh), .y(pcbranch));
Mux2_1#(32) pcbrmux(.d0(pcplus4), .d1(pcbranch), .s(pcsrc), .y(pcnextbr));
Mux2_1#(32) pcmux(.d0(pcnextbr), .d1({pcplus4[31:28], instr[25:0], 2'b00}), .s(jump), .y(pcnext));

//Register file logic
RegisterFile rf(.clk(clk), .we3(regwrite), .ra1(instr[25:21]),.ra2(instr[20:16]), .wa3(writereg), .wd3(result), .rd1(srca), .rd2(writedata));
Mux2_1#(5) wrmux(.d0(instr[20:16]), .d1(instr[15:11]), .s(regdst), .y(writereg));
Mux2_1#(32) resmux(.d0(aluout), .d1(readdata), .s(memtoreg), .y(result));

//Alu logic
Mux2_1#(32) srcbmux(.d0(writedata), .d1(signimm), .s(alusrc), .y(srcb));
Alu Alu(.inputULA(alucontrol), .srca(srca), .srcb(srcb), .zero(zero), .outputULA(aluout));

endmodule