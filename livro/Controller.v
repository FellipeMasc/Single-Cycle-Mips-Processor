`include "MainDecoder.v"
`include "AluDecoder.v"

module controller(
  input [5:0] op, funct,
  input zero,
  output memtoreg, memwrite,
  output reg pcsrc, // Modificado para 'reg'
  output alusrc,
  output regdst, regwrite,
  output jump,
  output [2:0] alucontrol
);
  wire [1:0] aluop;
  wire branch;

  maindec md(
    .op(op),
    .memtoreg(memtoreg),
    .memwrite(memwrite),
    .branch(branch),
    .alusrc(alusrc),
    .regdst(regdst),
    .regwrite(regwrite),
    .jump(jump),
    .aluop(aluop)
  );

  aludec ad(
    .funct(funct),
    .aluop(aluop),
    .alucontrol(alucontrol)
  );

  // Atribuição dentro do bloco 'always'
  always @(*) begin
    pcsrc = branch & zero;
    $display("Branch: %b | Zero: %b | PCSrc: %b", branch, zero, pcsrc);
  end
endmodule
