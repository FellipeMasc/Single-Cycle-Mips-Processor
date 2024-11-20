`include "Mips.v"

module testbench();
 reg clk;
 reg reset;
 wire [31:0] writedata, dataadr;
 wire memwrite;
 // instantiate device to be tested
 Mips dut(.clk(clk), .reset(reset), .writedata(writedata), .aluresult(dataadr), .memwrite(memwrite));
 // initialize test
 initial
 begin
 reset <= 1; #22; reset <= 0;
 end
 // generate clock to sequence tests
 always
 begin
 clk <= 1; #5; clk <= 0; # 5;
 end
 // check results
 always @ (negedge clk)
 begin
 if(memwrite)begin
	//display memwrite

 if(dataadr === 84 & writedata === 7)begin
 $display("Simulation succeeded");
 $stop;
 end else if(dataadr !== 80)begin
 $display("Simulation failed");
 $display("Simulation failed at time %0t | dataadr: %d | writedata: %d", $time, dataadr, writedata);
 $stop;
 end
 end
 end

	initial begin
        #200; // Adjust the timeout value as needed
        $display("Simulation timeout");
        $stop;
  end


 endmodule