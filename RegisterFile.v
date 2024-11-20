
module RegisterFile(
    input               clk,
    input       [4:0]   A1,
    input       [4:0]   A2,
    input       [4:0]   A3,

    input               RegWrite,
    input       [31:0]  WD3,
    output      [31:0]  RD2,
    output      [31:0]  RD1

);

    reg [31:0]  ROM [31:0];
    initial begin
        ROM[0] <= 32'b0;
        ROM[1] <= 32'b0;
        ROM[2] <= 32'b0;
        ROM[3] <= 32'b0;
        ROM[4] <= 32'b0;
        ROM[5] <= 32'b0;
        ROM[6] <= 32'b0;
        ROM[7] <= 32'b0;
        ROM[8] <= 32'b0;
        ROM[9] <= 32'b0;
        ROM[10] <= 32'b0;
        ROM[11] <= 32'b0;
        ROM[12] <= 32'b0;
        ROM[13] <= 32'b0;
        ROM[14] <= 32'b0;
        ROM[15] <= 32'b0;
    end

    assign RD1 = ROM[A1];
    assign RD2 = ROM[A2];

    always @(posedge clk) begin
        if (RegWrite) begin
            ROM[A3] <= WD3;
        end
    end
endmodule