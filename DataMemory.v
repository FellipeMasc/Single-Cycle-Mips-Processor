module DataMemory(
    input        clk,
    input        reset,
    input           [31:0]  A,
    input           [31:0]  WD,
    input                   WE,

    output   reg    [31:0]  RD
);
    reg [31:0]  DATA_MEM[84:0];

    always @(*) begin
            RD = DATA_MEM[A];
    end

    always @(posedge clk) begin
        if (WE) begin
            DATA_MEM[A] <= WD; 
        end
    end

endmodule