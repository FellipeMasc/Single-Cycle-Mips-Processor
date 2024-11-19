module MainDecoder(
	input [5:0] op,
	output reg memtoreg,
	output reg memwrite,
	output reg branch,
	output reg alusrc,
	output reg regdst,
	output reg regwrite,
	output reg jump,
	output reg [1:0] aluop
);

wire [8:0] controls;

assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop} = controls;

always @(*) begin
	case (op)
		6'b000000: controls <= 9'b110000010; // RTYPE
		6'b100011: controls <= 9'b101001000; // LW
		6'b101011: controls <= 9'b001010000; // SW
		6'b000100: controls <= 9'b000100001; // BEQ
		6'b001000: controls <= 9'b101000000; // ADDI
		6'b000010: controls <= 9'b000000100; // J
		default:   controls <= 9'bxxxxxxxxx; // illegal op 
	endcase
end


endmodule