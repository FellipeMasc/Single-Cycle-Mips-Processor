`include "Top.v"

module testbench();
	reg clk;
	reg reset;
	wire [31:0] writedata, dataadr;
	wire memwrite;

	Top dut(clk, reset, writedata, dataadr, memwrite);

	// initial begin
	// 	reset <= 1;
	// 	#22; 
	// 	reset <= 0;
	// end

	always begin
		clk <= 1; 
		#5; 
		clk <= 0; 
		#5;
	end

	always @(posedge clk)
		begin
			if (memwrite) begin
        $display("memwrite: %b, dataadr: %h, writedata: %h", memwrite, dataadr, writedata);
				if (dataadr === 84 & writedata === 7) begin
					$display ("Simulation succeeded");
					$stop;
					end else if (dataadr !== 80) begin
					$display ("Simulation failed");
					$stop;
				end
			end
		end

	initial begin
        #10000; // Adjust the timeout value as needed
        $display("Simulation timeout");
        $stop;
  end

	// initial begin
  //       $monitor("Time: %0t | clk: %b | reset: %b | memwrite: %b | dataadr: %h | writedata: %h", 
  //                $time, clk, reset, memwrite, dataadr, writedata);
  // end
endmodule