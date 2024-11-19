// module DataMemory(
// 	input clk, we,
// 	input [31:0] a, wd,
// 	output [31:0] rd
// );

// reg [31:0] RAM[71:0];

// assign rd = RAM[a[31:2]];

// always @(posedge clk) begin
// 	if(we) begin
// 		RAM[a[31:2]] <= wd;
// 		$display("DataMemory: %d <= %d", a[31:2], wd);
// 	end
// end


// endmodule
module DataMemory(
    // System Clock
    input        clk,

    // User Interface
    input           [31:0]  a,
    input           [31:0]  wd,
    input                   we,

    output   reg    [31:0]  rd
);
    integer fd;
    reg [31:0]  RAM[84:0];

    always @(*) begin
            rd = RAM[a];
    end


    initial begin
        fd = $fopen("./MEM_Data.txt", "w");  
        #500
        $fclose(fd);
    end

    always @(posedge clk) begin
        if (we) begin
            RAM[a] <= wd; 
            $fdisplay(fd,"The Write Address A is %h", a);
            $fdisplay(fd,"RAM[A] is %h", wd);
        end
    end

endmodule