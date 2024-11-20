 module InstructionMemory (input  [31:0] A,
 output [31:0] RD);
	reg [31:0] RAM[31:0];

	// initial begin
	// 	$readmemh("./memfile.dat",RAM,0,17);
	// end
	initial begin
        RAM[0]  = 32'h20020005;
        RAM[1]  = 32'h2003000c;
        RAM[2]  = 32'h2067fff7;
        RAM[3]  = 32'h00e22025;
        RAM[4]  = 32'h00642824;
        RAM[5]  = 32'h00a42820;
        RAM[6]  = 32'h10a7000a;
        RAM[7]  = 32'h0064202a;
        RAM[8]  = 32'h10800001;
        RAM[9]  = 32'h20050000;
        RAM[10] = 32'h00e2202a;
        RAM[11] = 32'h00853820;
        RAM[12] = 32'h00e23822;
        RAM[13] = 32'hac670044;
        RAM[14] = 32'h8c020050;
        RAM[15] = 32'h08000011;
        RAM[16] = 32'h20020001;
        RAM[17] = 32'hac020054;

    end

	assign RD = RAM[A[31:2]];
endmodule
//  module InstructionMemory (input  [31:0] A,
//  output [31:0] RD);
//  reg [7:0] RAM[71:0];
//  initial
//  begin
//  $readmemh("./memfile2.dat",RAM,0,71);
//  end
//  assign RD = {{RAM[A]},{RAM[A+32'd1]},{RAM[A+32'd2]},{RAM[A+32'd3]}};
// endmodule
