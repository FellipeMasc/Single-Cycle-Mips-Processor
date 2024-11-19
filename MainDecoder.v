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



always @(*) begin
    case (op)
        // R type no Immediate Instruction
        6'b000000 : begin
            regwrite = 1'b1;
            regdst   = 1'b1;
            alusrc   = 1'b0;
            branch   = 1'b0;
            memwrite = 1'b0;
            memtoreg = 1'b0;
            aluop    = 2'b10;
            jump     = 1'b0;
        end
        // beq Instruction
        6'b000100 : begin
            regwrite = 1'b0;
            regdst   = 1'b0;    // dont care
            alusrc   = 1'b0;
            branch   = 1'b1;    
            memwrite = 1'b0;
            memtoreg = 1'b0;    // dont care
            aluop    = 2'b01;
            jump     = 1'b0;
        end
        // sw Instruction
        6'b101011 : begin
            regwrite = 1'b0;
            regdst   = 1'b0;
            alusrc   = 1'b1;
            branch   = 1'b0;
            memwrite = 1'b1;
            memtoreg = 1'b1;
            aluop    = 2'b00;
            jump     = 1'b0;
        end
        // lw Instruction
        6'b100011 : begin
            regwrite = 1'b1;
            regdst   = 1'b0;
            alusrc   = 1'b1;
            branch   = 1'b0;
            memwrite = 1'b0;
            memtoreg = 1'b1;
            aluop    = 2'b00;
            jump     = 1'b0;
        end
        // addi Instruction
        6'b001000 : begin
            regwrite = 1'b1;
            regdst   = 1'b0;
            alusrc   = 1'b1;
            branch   = 1'b0;
            memwrite = 1'b0;
            memtoreg = 1'b0;
            aluop    = 2'b00;
            jump     = 1'b0;
        end
        // J type Instruction
        6'b000010 : begin
            regwrite = 1'b0;
            regdst   = 1'b0;
            alusrc   = 1'b0;
            branch   = 1'b0;
            memwrite = 1'b0;
            memtoreg = 1'b0;
            aluop    = 2'b00;
            jump     = 1'b1;
        end
        default: ;
    endcase
end


endmodule