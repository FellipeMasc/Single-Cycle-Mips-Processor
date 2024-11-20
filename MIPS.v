`include "RegisterFile.v"
`include "ALU.v"
`include "Signext.v"
`include "PCounter.v"
`include "InstructionMemory.v"
`include "ControlUnit.v"
`include "DataMemory.v"
`include "ALUControl.v"


 module Mips (
  input clk, reset
  // output [31:0] writedata, aluresult,
  // output memwrite
);

  // assign writedata = WriteData;
  // assign aluresult = ALUResult;
  // assign memwrite = MemWrite;
  wire [31:0]     PC;
  wire [31:0]     Instr;
  wire [31:0]     ReadData, WriteData;
  wire [31:0]     SrcA,SrcB, ALUResult;
  wire            RegWrite, MemWrite;

  wire            RegDst,ALUSrc,MemtoReg;

  wire [4:0]      WriteReg;
  wire [31:0]     SignImm,RD2;
  wire [31:0]     WD3;

  wire            PCSrc,Branch,Zero;
  wire            Jump;

  wire [2:0]      ALUControl;
  wire [1:0]      ALUOp;
  
  assign PCSrc        = Branch & Zero;
  assign WriteReg     = RegDst ? Instr[15:11] : Instr[20:16];
  assign SrcB         = ALUSrc ? SignImm : RD2;
  assign WD3          = MemtoReg ? ReadData : ALUResult;
  assign WriteData    = RD2;

 // next PC
  PC_Counter u_PC_Counter(
    .clk(clk),
    .rst_n(reset),
    .PC(PC),
    .PCSrc(PCSrc),
    .Jump(Jump),
    .Jump_low_26Bit(Instr[25:0]),
    .SignImm(SignImm)
  );

  // instruction memory
  InstructionMemory InstructionMemory(
    .RD(Instr),
    .A(PC)
  );

  // controller
  ControlUnit ControlUnit(
    .clk(clk),
    .reset(reset),
    .Opcode(Instr[31:26]),
    .MemWrite(MemWrite),
    .RegWrite(RegWrite),
    .RegDst(RegDst),
    .ALUSrc(ALUSrc),
    .MemtoReg(MemtoReg),
    .ALUOp(ALUOp),
    .Jump(Jump),
    .Branch(Branch)
  );

  RegisterFile RegisterFile(
        .clk(clk),
        .A1(Instr[25:21]),
        .RD1(SrcA),
        .A2(Instr[20:16]),
        .RD2(RD2),
        .A3(WriteReg),
        .RegWrite(RegWrite),
        .WD3(WD3)
  );

  SignExtend SignExtend(
        .a(Instr[15:0]),
        .y(SignImm)
  );

  // Data Memory
  DataMemory DataMemory(
        .clk(clk),
        .reset(reset),
        .A(ALUResult),
        .RD(ReadData),
        .WE(MemWrite),
        .WD(WriteData)
  );

  ALUControl u_ALUControl(
    .ALUOp(ALUOp),
    .Funct(Instr[5:0]),
    .ALUControl(ALUControl)
  );

  ALU u_ALU(
    .SrcA(SrcA),
    .SrcB(SrcB),
    .ALUControl(ALUControl),
    .ALUResult(ALUResult),
    .Zero(Zero)
  );

  // debug all mips
  // always @(posedge clk) begin
  //   $display("PC: %d",PC);
  //   $display("Instr: %h",Instr);
  //   $display("ReadData: %d",ReadData);
  //   $display("WriteData: %d",WriteData);
  //   $display("SrcA: %d",SrcA);
  //   $display("SrcB: %d",SrcB);
  //   $display("ALUResult: %d",ALUResult);
  //   $display("RegWrite: %d",RegWrite);

  //   $display("MemWrite: %d",MemWrite);
  //   $display("RegDst: %d",RegDst);
  //   $display("ALUSrc: %d",ALUSrc);

  //   $display("MemtoReg: %d",MemtoReg);
  //   $display("WriteReg: %d",WriteReg);
  //   $display("SignImm: %d",SignImm);
  //   $display("RD2: %d",RD2);
  //   $display("WD3: %d",WD3);
  //   $display("PCSrc: %d",PCSrc);
  //   $display("Branch: %d",Branch);
  //   $display("Zero: %d",Zero);
  //   $display("Jump: %d",Jump);
  //   $display("ALUControl: %d",ALUControl);
  //   $display("ALUOp: %d",ALUOp);

  // end

 

 endmodule