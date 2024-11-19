module Alu (
			input  [2:0]  inputULA, 
			input  [31:0] srca,
			input  [31:0] srcb,
			output zero,
			output reg [31:0] outputULA);
	

always @(*) begin
        case (inputULA)
            3'b010 : begin
                outputULA = srca + srcb;
            end 
            3'b110 : begin
                outputULA = srca - srcb;
            end
            3'b000 : outputULA = srca & srcb;
            3'b001 : outputULA = srca | srcb;
            3'b111 : outputULA = (srca < srcb) ? 32'b1 : 32'b0;
            default: ;
        endcase
end

assign zero = (outputULA) ? 1'b0 : 1'b1;

endmodule