module alu (
    input  [31:0] srca,
    input  [31:0] srcb,
    input  [2:0]  inputULA, 
    output reg [31:0] outputULA,
    output zero);

always @(*) begin
    outputULA = 32'b0; // Valor padrão para evitar latches e 'X's
    case (inputULA)
        3'b010 : outputULA = srca + srcb;                    // ADD
        3'b110 : outputULA = srca - srcb;                    // SUB
        3'b000 : outputULA = srca & srcb;                    // AND
        3'b001 : outputULA = srca | srcb;                    // OR
        3'b111 : outputULA = ($signed(srca) < $signed(srcb)) ? 32'b1 : 32'b0; // SLT
        default: outputULA = 32'b0; // Opcional, já que atribuimos acima
    endcase
end

assign zero = (outputULA == 32'b0);

endmodule