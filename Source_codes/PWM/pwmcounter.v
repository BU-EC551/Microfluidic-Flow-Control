`timescale 1ns / 1ps

// Reference:  https://blog.digilentinc.com/how-to-control-a-servo-with-fpga/

module pwmcounter (
	input clr,
	input clk,
	output reg [19:0]count
);
    initial
    begin
    count<=0;
    end
    // Run on the positive edge of the clock
	always @ (posedge clk)
	begin
	    // If the clear button is being pressed or the count
	    // value has been reached, set count to 0.
	    // This constant depends on the refresh rate required by the
	    // servo motor you are using. This creates a refresh rate
	    // of 10ms. 100MHz/(1/10ms) or (system clock)/(1/(Refresh Rate)).
		if (clr == 1'b1 || count == 23'd1000000) //removed 1 zero
			begin
			count <= 20'b0;
			end
		// If clear is not being pressed and the 
		// count value is not reached, continue to increment
		// count. 
		else
			begin
			count <= count + 1'b1;
			end
	end
endmodule