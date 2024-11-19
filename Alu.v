module Alu (
			input  [2:0]  inputULA, 
			input  [31:0] srca,
			input  [31:0] srcb,
			output reg zero,
			output reg [31:0] outputULA);
	

always @(*) begin
	if(inputULA == 4'b0010)
		outputULA <= srca + srcb;
	if(inputULA == 4'b0110)
		outputULA <= srca - srcb;
	if(inputULA == 4'b0000)
		outputULA <= srca & srcb;
	if(inputULA == 4'b0001)
		outputULA <= srca | srcb;
	if(inputULA == 4'b0111) begin
		if (a < b)
			outputULA <= 1;
		if (a > b)
			outputULA <= 0;
		if (a == b)
			outputULA <= 0;
	end
	zero = outputULA == 0;
end

endmodule